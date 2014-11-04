#!/usr/bin/env ruby

require "pry"

# Quick Sort implementation

def get_pivot_index arr, type
  case type
  when :first
    0
  when :last
    -1
  when :median
    if arr.size>2
      { 0 => arr[0], (arr.size-1)/2 => arr[(arr.size-1)/2], -1 => arr[-1] }.sort_by(&:last)[1][0]
    else
      arr[0] < arr [-1] ? 0 : -1
    end
  when :random
    rand arr.size
  when :rmedian
    if arr.size>2
      p = (0...arr.size).to_a.shuffle[0..2] #!!! awful
      { p[0] => arr[p[0]], p[1] => arr[p[1]], p[2] => arr[p[2]] }.sort_by(&:last)[1][0]
    else
      arr[0] < arr [-1] ? 0 : -1
    end
  else
    raise 'Unknown index type. Use only [:first, :median, :last, :random, :rmedian]'
  end
end

def partition arr, type
  pivot = get_pivot_index arr, type
  arr[0], arr[pivot] = arr[pivot], arr[0] if pivot != 0
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

def qsort arr, type
  return arr if arr.size <= 1
  @count+=arr.size-1
  arr, p = partition arr, type
  arr = qsort(arr[0...p], type) + [arr[p]] + qsort(arr[p+1..-1], type)
end


def get_from_file file_name
  arr = []
  File.open(file_name, 'r').each_line do |line|
    arr << line.to_i
  end
  arr
end

sample = (1..1000).to_a.shuffle

if $*.any?
  sample = get_from_file($*[0])
end


[:first, :last, :median, :random, :rmedian].each do |pivot_type|
  puts "Array size = #{sample.size}, Pivot type: #{pivot_type}"
  @count = 0
  res = qsort sample.clone, pivot_type
  puts "Comparsions count: #{@count}"

end
