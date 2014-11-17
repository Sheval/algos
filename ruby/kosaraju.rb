#!/usr/bin/env ruby
# kosaraju algo sandbox

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
    line_array = line.split.map(&:to_i)
    yield line_array
  end
end

class Kosaraju

  def initialize
    @adj_list = []
    @graph = {}
    @visited = []
    @vertices = []
    @order = []
    @scc = []
  end

  def fill_graph
    @adj_list.each do |tail, head|
      @graph[tail] ||= []
      @graph[tail] << head
    end
    @vertices = @adj_list.flatten.uniq.sort
  end

  def dfs vertex
    @visited[vertex] = true
    @graph[vertex].each do |adj_vertex|
      dfs adj_vertex unless @visited[adj_vertex]
    end if @graph[vertex]
    @t += 1
    @order[vertex] = @t
  end
  stackless_method :dfs

  def dfs_loop
    @t = 0
    @vertices.each do |vertex|
      dfs vertex unless @visited[vertex]
    end
  end

  def invert_graph
    @graph = {}
    @adj_list.each do |head, tail|
      @graph[@order[tail]] ||= []
      @graph[@order[tail]] << @order[head]
    end
  end

  def scc vertex
    @visited[vertex] = true
    @graph[vertex].each do |adj_vertex|
      scc adj_vertex unless @visited[adj_vertex]
    end if @graph[vertex]
    @scc_size += 1
  end
  stackless_method :scc

  def scc_count
    @visited = []
    @vertices.reverse_each do |vertex|
      @scc_size = 0
      scc vertex unless @visited[vertex]
      @scc << @scc_size if @scc_size > 0
    end
  end

  def main
    if $*.any?
      wrap_time("Load file (adj. list)"){ read_from_file($*[0]) { |arr| @adj_list << arr } }
      wrap_time("Fill graph"){ fill_graph }
    end

    puts "Edges - #{@adj_list.size}"
    puts "Vertices - #{@vertices.size}"

    wrap_time("DFS loop"){ dfs_loop }
    wrap_time("Invert graph"){ invert_graph }
    wrap_time("Count SCC's"){ scc_count }

    p @scc.sort.reverse.first(5)
  end

end

wrap_time("TOTAL"){Kosaraju.new.main}
