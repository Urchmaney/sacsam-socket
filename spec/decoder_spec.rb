require './lib/decoder'

RSpec.describe Decoder do
  describe '.get_protocol_number' do
    it 'return protocol Number for valid byte array' do
      stream = "xx\x04\x01\r\n"
      expect(Decoder.get_protocol_number(stream.bytes)).to eql(1)
    end

    it 'returns 0 as protocol number for invalid byte array' do
      stream = 'wrong'
      expect(Decoder.get_protocol_number(stream.bytes)).to eql(0)
    end
  end

  describe '.isValidStream' do
    it 'returns false for in-valid stream' do
      input_stream = 'unknown'
      expect(Decoder.valid_stream?(input_stream.bytes)).to be_falsey
    end

    it 'return true for valid stream' do
      input_stream = "xx\r\n"
      expect(Decoder.valid_stream?(input_stream.bytes)).to be_truthy
    end
  end

  describe '.gps_positioning' do
    it 'return the date,longitude and latitude' do
      input_stream = "xx\f\n\n\x03\x17\x0F2\x17\x9C(:\x1DJ\x14g\t\\\x05\x1F\"<\r\n"
      expect(Decoder.gps_positioning(input_stream.bytes)).to eql({})
    end
  end

  describe '.login' do
    it 'return the corresponding IMEI' do
      input_stream = "xx\n\x01\x01#Eg\x89\x01#E\x01\r\n"
      another_stream = "xx\n\x01\x03Y3\x90u#\x91@\r\n"
      expect(Decoder.login(input_stream.bytes)).to eql('123456789012345')
      expect(Decoder.login(another_stream.bytes)).to eql('359339075239140')
    end
  end
end
