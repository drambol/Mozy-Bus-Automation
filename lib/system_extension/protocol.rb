# Public: Add extension method to Element class
#
class Net::BufferedIO

  alias_method :old_rbuf_fill, :rbuf_fill
  def rbuf_fill
    old_read_timeout = read_timeout
    self.read_timeout = 180
    old_rbuf_fill
    self.read_timeout = old_read_timeout
  end

end

