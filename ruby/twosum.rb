#!/usr/bin/env ruby
# 2-sum algo sandbox

def wrap_time message
  t1 = Time.now
  res = yield
  t2 = Time.now
  puts "#{message} - Elapsed time #{t2-t1}s"
  res
end

def read_from_file file_name
  File.open(file_name, 'r').each_line do |line|
    yield line
  end
end

class TwoSum

  def initialize
    @numbers = []
    @sum = {}
  end

  def main
    wrap_time("Load file"){ read_from_file($*[0]) { |line| @numbers<<line.to_i } } if $*.any?
    puts "Total size - #{@numbers.size}"
    wrap_time("Sorting..."){ @numbers.sort! }
    wrap_time("Counting...") do
      right = -1
      @numbers.each do |number|
        break if number > 5000
        next if number + @numbers[right] < -10000
        while number + @numbers[right] > 10000
          right -= 1
        end
        i = right
        while (-10000..10000).include?(number + @numbers[i])
          @sum[number + @numbers[i]] = true if number != @numbers[i]
          i -= 1
        end
      end
    end
    puts "2-SUM count: #{@sum.size}"
  end

end

wrap_time("TOTAL"){ TwoSum.new.main }
