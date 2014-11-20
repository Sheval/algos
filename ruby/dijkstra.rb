#!/usr/bin/env ruby
# dijkstra algo sandbox

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
    line_array = line.split
    yield line_array
  end
end

class Dijkstra

  def initialize
    @graph = {}
    @explored = []
    @frontier = []
  end

  def load_vertex arr
    @graph[arr.first.to_i] = arr[1..-1].reduce ([]) do |memo, pair|
       head, length = pair.split(',').map(&:to_i)
       memo << {head: head, length: length}
    end
  end

  def add_vertex vertex, length
    @explored[vertex] = length
    @graph[vertex].each { |pair| @frontier<<[vertex, pair[:head], @explored[vertex] + pair[:length]] }
    @frontier.reject! { |i, j| @explored[i] && @explored[j] }
  end

  def main_loop
    add_vertex 1, 0
    while @frontier.any? do
      min_edge = @frontier.sort{ |a,b| a[2] <=> b[2] }.first
      add_vertex min_edge[1], min_edge[2]
    end
  end

  def main
    wrap_time("Load graph"){ read_from_file($*[0]) { |arr| load_vertex arr } } if $*.any?
    puts "Graph size - #{@graph.size} vertices"

    main_loop

    if @graph.size == 200
      puts [7,37,59,82,99,115,133,165,188,197].map{|index| @explored[index]}.join(',')
    else
      p @explored
    end
  end

end

wrap_time("TOTAL"){Dijkstra.new.main}
