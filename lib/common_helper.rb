def set_timezone(timezone)
  Time.zone = timezone
  Chronic.time_class = Time.zone
end

def with_timezone(timezone)
  pre_timezone = ActiveSupport::TimeZone[Time.now.utc_offset / 3600]
  set_timezone(timezone)
  yield
ensure
  set_timezone(pre_timezone)
end

def number_to_human_size(size, allow_negative = false)
  size = [size, 0].max unless allow_negative
  return size.to_s if size.zero?
  size, unit = case
    when size.abs < 1024;    [size, ' GB']
    when size.abs < 1024**2; [(size / 1024.to_f), ' TB']
    else                     [(size / 1024**2.to_f), ' PB']
  end
  size = ('%.1f' % size).sub('.0', '')
  size << unit
rescue
  nil
end

def friendly_hash(h)
  Hash[h.map{ |k, v| [k.gsub(/[\s|-]+/, '_').downcase, v]}]
end
