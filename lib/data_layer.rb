require 'pg'

module DataLayer
  module_function

  def exec(statement)
    con = PG.connect dbname: 'tracker_development', user: 'urchmaney'
    rs = con.exec statement
  rescue StandardError => e
    p e.message
  ensure
    con&.close
    rs
  end
  
  def add_imei(imei)
    "INSERT INTO devices (imei) Values (#{imei})"
  end

  def create_devices_table
    'CREATE TABLE devices (ID SERIAL PRIMARY KEY, IMEI varchar(16) NOT NULL, ACTIVE BOOLEAN DEFAULT false)'
  end

  def create_coordinates_table
    'CREATE TABLE coordinates (ID SERIAL PRIMARY KEY, LATITUDE varchar(10) NOT NULL, LONGITUDE varchar(10) NOT NULL,
    DEVICEID int NOT NULL REFERENCES devices(ID))'
  end

  def add_coordinate(lat, lon, device_id)
    "INSERT INTO coordinates (Latitude,Longitude,DeviceId) values(#{lat},#{lon},#{device_id})"
  end
end
