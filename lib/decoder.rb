class Decoder
  PROTOCOL_INDEX = 3
  DATA_START_INDEX = 4

  def self.get_protocol_number(byte_array)
    return 0 unless valid_stream?(byte_array)

    byte_array[PROTOCOL_INDEX]
  end

  def self.login(byte_array)
    result = ''
    (DATA_START_INDEX...DATA_START_INDEX + 8).each do |index|
      result << ('0' + byte_array[index].to_s(16))[-2, 2] # trick to make string in {00} format
    end
    result.sub!(/^[0]+/, '') # remove leading zero and return
  end

  # accept byte array and check validity
  def self.valid_stream?(byte_array)
    !byte_array.join.match(/^120120\d*1310$/).nil?
  end
end
