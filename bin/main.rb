require 'socket'
require '../lib/data_layer'
require '../lib/decoder'
require '../lib/response'

server = TCPServer.open(2021)

loop do
  client = server.accept
  Thread.start(client) do |connection|
    imei = Decoder.login(connection.gets.bytes)
    DataLayer.add_imei(imei)
    connection.puts Response.login(true)
    while (stream_bytes = connection.gets.bytes)
      perform_action(stream_bytes, connection)
    end
  end
end

def perform_action(bytes_array, connection, imei)
  protocol = Decoder.get_protocol_number(bytes_array)
  case protocol
  when 10
    coordinate_data = Decoder.gps_positioning(bytes_array)
    DataLayer.add_coordinate(coordinate_data[:latitude], coordinate_data[:longitude], imei)
    connection.puts Response.add_coordinate(bytes_array)
  when 14
    connection.close
    Thread.exit
  when 15
    connection.puts Response.factory_restore(bytes_array)
  end
end
