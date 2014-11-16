# kosaraju algo sandbox

require "pry"

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

def fill_vertices
  @adj_list.each do |pair|
    @vertices[pair.first] ||= []
    @vertices[pair.first] << pair.last
  end
end

@adj_list = []
@vertices = {}

if $*.any?
  wrap_time("Load file (adj. list)"){ read_from_file($*[0]) { |arr| @adj_list << arr } }
  wrap_time("Fill vertices"){ fill_vertices }
end

puts "Adj. list size - #{@adj_list.size}"
puts "Vert. arr size - #{@vertices.size}"

@visited = []

def dfs vertex
  @visited[vertex] = true
  @vertices[vertex].each do |adj_vertex|
    dfs adj_vertex unless @visited[adj_vertex]
  end if @vertices[vertex]
end

dfs 1

binding.pry
