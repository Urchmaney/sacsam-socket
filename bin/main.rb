require 'socket'
require '../lib/data_layer'
require '../lib/decoder'
require '../lib/response'

server = TCPServer.open(2021)

loop do
  client = server.accept
  stream_bytes = client.gets.bytes
end

def perform_action(bytes_array, connection)
  protocol = Decoder.get_protocol_number(bytes_array)
  case protocol
  when 1
    imei = Decoder.login(bytes_array)
    DataLayer.add_imei(imei)
    connection.puts Response.login(true)
  when 10
    coordinate_data = Decoder.gps_positioning(bytes_array)
    DataLayer.add_coordinate(coordinate_data[:latitude], coordinate_data[:longitude])
    connection.puts Response.add_coordinate(bytes_array)
  else
  end
end

