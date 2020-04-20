require 'pg'

begin
    con = PG.connect dbname: 'tracker_development', user: 'urchmaney'
    rs = con.exec 'SELECT * FROM tracks'
    rs.each do |row|
        p "#{row["id"]}      #{row["name"]}      #{row["created_at"]}"
    end
    p con.server_version
rescue => exception
    p exception.message
ensure
    con.close if con
end

def addImei(imei)
  
end