require "pry"

# Unoriented graph
class Graph
  def initialize(vertex_list = [])
    @vertices = vertex_list
  end

  def clone
    Graph.new(@vertices.clone)
  end

  def get_vertex vertex
    @vertices[vertex]
  end

  def add_vertex vertex, adj_vertex_list
    @vertices[vertex] = adj_vertex_list
  end

  def contract_edge v1, v2
#    p '-===================================-'
#    puts "v1 = #{v1}, v2 = #{v2}"
    @vertices[v1] += @vertices[v2]
#    p @vertices
    @vertices[v1] -= [v1, v2]
#    p @vertices
    @vertices[v2] = nil
#    p @vertices
    @vertices.each {|v| v.each_index { |i| v[i] = v1 if v[i] == v2 } if v }
#    p @vertices
  end

  def get_vertices
    @vertices.reduce([]){|ac,v| ac << (v ? @vertices.index(v) : nil) }.compact
  end

  def do_random_contraction
#   p @vertices
    actual_vertices = get_vertices
    while actual_vertices.size>2 do
      v1 = actual_vertices[rand(actual_vertices.size)]
      v2 = @vertices[v1][rand(@vertices[v1].size)]
      contract_edge v1, v2
      actual_vertices = get_vertices
    end
    @vertices[actual_vertices[0]].size
  end

end

def get_from_file file_name
  graph = Graph.new
  File.open(file_name, 'r').each_line do |line|
    line_array = line.split.map(&:to_i)
    graph.add_vertex line_array[0], line_array[1..-1]
  end
  graph
end

if $*.any?
  sample = get_from_file($*[0])
  min_cut = sample.get_vertex(1).size
  $*[1].to_i.times do
    graph = get_from_file($*[0])
    current_cut = graph.do_random_contraction
    min_cut = current_cut if min_cut > current_cut
  end
  puts "Min cut = #{min_cut} (iterations: #{$*[1]})"
end
