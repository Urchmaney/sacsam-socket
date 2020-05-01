module Response
  module_function

  def login(success)
    pro_num = success ? 1 : 68
    [120, 120, 1, pro_num, 13, 10].pack('c*')
  end

  def add_coordinate(bytes)
    [120, 120, 0, 10, *bytes[4..9], 13, 10].pack('c*')
  end
end
