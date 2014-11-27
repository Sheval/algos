#!/usr/bin/env ruby
# 2-sum algo sandbox

require "pry"
require_relative "stackless"

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
    @numbers = {}
  end

  def main
    wrap_time("Load file"){ read_from_file($*[0]) { |line| @numbers[line.to_i] = true } } if $*.any?
    puts "Hash size - #{@numbers.size}"
    arr = []
    wrap_time("Load file"){ read_from_file($*[0]) { |line| arr << line.to_i } } if $*.any?
    puts "Ary size - #{arr.size}"
  end

end

wrap_time("TOTAL"){TwoSum.new.main}
