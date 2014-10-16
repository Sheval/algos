#!/usr/bin/env ruby

# Inversions
# Bruteforce method
def bf_inversions arr
  count = 0
  (0...arr.size).each do |i|
    ((i+1)...arr.size).each do |j|
      count+=1 if arr[i] > arr[j]
    end
  end
  count
end

def get_from_file file_name
  arr = []
  File.open(file_name, 'r').each_line do |line|
    arr << line.to_i
  end
  arr
end

sample = [6,5,4,3,2,1]

if ARGV.any?
  sample = get_from_file(ARGV[0])
end

p sample
puts bf_inversions sample

