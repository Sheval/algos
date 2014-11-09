def wrap_time
  t1 = Time.now
  res = yield
  t2 = Time.now
  puts "Elapsed time #{t2-t1}s"
  res
end

def sum_count1 s
  r = 0
  s.times { |i| r += i }
  r
end

def sum_count2 s
  (1...s).reduce(:+)
end

def sum_count3 s
  r = 0
  (1...s).each {|i| r += i }
  r
end

count = 100000000
spawn do
  puts "sum_count (+) #{count}..."
  wrap_time { puts sum_count1 count }
end
spawn do
  puts "sum_count (reduce) #{count}..."
  wrap_time { puts sum_count2 count }
end
spawn do
  puts "sum_count (each) #{count}..."
  wrap_time { puts sum_count3 count }
end
