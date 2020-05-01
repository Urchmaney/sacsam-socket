require './lib/response'

RSpec.describe Response do
  describe 'login' do
    it 'Return 0x44 for failed login' do
      expect(Response.login(false)).to eql("xx\x01D\r\n")
    end

    it 'Return 0x01 for success login' do
      expect(Response.login(true)).to eql("xx\x01\x01\r\n")
    end
  end

  describe 'response for add gps coordinate' do
    it 'Returns appropriate response for stream' do
      stream = "xx\x12\x10\n\x03\x17\x0F2\x17\x9C\x02k?>\f\"\xADe\x1F4`\r\n"
      expect(Response.add_coordinate(stream.bytes)).to eql("xx\x00\n\n\x03\x17\x0F2\x17\r\n")
    end
  end
end
