#!/usr/bin/env ruby

require "pry"

# Quick Sort implementation

def partition arr, pivot
  arr[0], arr[pivot] = arr[pivot], arr[0] if pivot > 0
  i = 1
  (1...arr.size).each do |j|
    if arr[j] < arr[0]
      arr[i], arr[j] = arr[j], arr[i]
      i += 1
    end
  end
  arr[i-1], arr[0] = arr[0], arr[i-1]
  return arr, i-1
end

def qsort arr
  @count+=arr.size-1
  return arr if arr.size <= 1
  arr, p = partition arr, arr.size-1
  arr = qsort(arr[0...p]) + [arr[p]] + qsort(arr[p+1..-1])
end


def get_from_file file_name
  arr = []
  File.open(file_name, 'r').each_line do |line|
    arr << line.to_i
  end
  arr
end

@count = 0
p qsort [5,3,2,4,1,6]
p @count

@count = 0
p qsort [3,8,2,5,1,4,7,6]
p @count
