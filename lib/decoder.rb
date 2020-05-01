class Decoder
  def self.decode(stream)
    result = { protocol: 0, data: '' }
    return result unless valid_stream?(stream)

    result[:protocol] = stream[PROTOCOL_INDEX]
    (DATA_START_INDEX...stream[DATA_LENGTH_INDEX] + DATA_START_INDEX).each do |ele|
      result[:data] << stream[ele].hex.to_s
    end
    result
  end

  def self.get_protocol_number(byte_array, index)
    byte_array[index]
  end

  # accept byte array and check validity
  def self.valid_stream?(stream)
    !stream.join.match(/^120120\d*9211492110$/).nil?
  end
end
