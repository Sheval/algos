#!/usr/bin/env ruby
# median algo sandbox

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

class Median

  def initialize
    @stream = []
    @sum = 0
  end

  def main
    wrap_time("Load file"){ read_from_file($*[0]) { |line| @stream<<line.to_i } } if $*.any?
    puts "Total size - #{@stream.size}"
    wrap_time("Counting...") do
      @stream.each_index do |i|
        @sum += @stream[0..i].sort[i/2]
      end
    end
    puts "Median count: #{@sum.size}"
  end

end

wrap_time("TOTAL"){ Median.new.main }
