# Matrix multiplication

def product_square_matrices a, b
  c = Array.new(a.size) { Array.new(a.size, 0) }
  (0...c.size).each do |i|
    (0...c.size).each do |j|
      (0...c.size).each do |k|
        c[i][j]+=a[i][k]*b[k][j]
      end
    end
  end
  c
end

def get_matrix_from_file file_name
  arr = []
  File.open(file_name, 'r').each_line do |line|
    arr << line.split.map(&:to_i)
  end
  arr
end

a = [[1,2,3],
     [4,5,6],
     [7,8,9]]
p product_square_matrices a, a

b = [[1, 2, 3, 4, 5 ],
     [6, 7, 8, 9, 10],
     [11,12,13,14,15],
     [16,17,18,19,20],
     [21,22,23,24,25]]
p product_square_matrices b, b

z = get_matrix_from_file "sample_matrix_201410200002.txt"
p product_square_matrices z, z
