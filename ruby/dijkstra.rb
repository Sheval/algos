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

  def search_path start, finish
    add_vertex start
    @frontier.each do |pair|

    end
  end

  def main_loop
    @graph.each_key do |vertex|
      search_path 1, vertex unless @explored[vertex]
    end
  end

  def main
    wrap_time("Load graph"){ read_from_file($*[0]) { |arr| load_vertex arr } } if $*.any?
    puts "Graph - #{@graph.size}"

    main_loop

    #p @graph

    #binding.pry
  end

end

wrap_time("TOTAL"){Dijkstra.new.main}
