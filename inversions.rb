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

def sub_sort arr
  if arr.size > 1
    sub_merge sub_sort(arr[0..arr.size/2-1]), sub_sort(arr[arr.size/2..-1])
  else
    arr
  end
end

def sub_merge a, b
  res = []
  i, j = 0, 0
  (0...a.size+b.size).each do |k|
    if i >= a.size
      res << b[j]
      j+=1
      next
    end
    if j >= b.size
      res << a[i]
      i+=1
      next
    end
    if a[i] < b[j]
      res<<a[i]
      i+=1
    else  # b < a
      res<<b[j]
      j+=1
    end
  end
  res
end

sample = [6,5,4,3,2,1]

if ARGV.any?
  sample = get_from_file(ARGV[0])
end

p sample
p sub_sort sample

