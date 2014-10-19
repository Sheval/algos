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
