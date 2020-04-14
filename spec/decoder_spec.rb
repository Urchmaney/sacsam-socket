require './lib/decoder'

RSpec.describe Decoder do
  describe '.decode' do
    it 'returns zero protocol and empty data for invalid stream' do
      data = 'kvjv'
      expect(Decoder.decode(data.bytes)[:protocol]).to eql(0)
      expect(Decoder.decode(data.bytes)[:data]).to eql('')
    end

    it 'returns data for the protocol for valid data' do
    end
  end

  describe '.isValidStream' do
    it 'returns false for in-valid stream' do
      input_stream = 'unknown'
      expect(Decoder.valid_stream?(input_stream.bytes)).to be_falsey
    end

    it 'return true for valid stream' do
      input_stream = 'xx\r\n'
      expect(Decoder.valid_stream?(input_stream.bytes)).to be_truthy
    end
  end
end
