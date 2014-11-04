def arr_to_i arr
  arr.join.to_i
end

def bigsum a, b
  a, b = b, a if b.size > a.size
  c = []
  a.each_index do |i|
    c[i] = 0 unless c[i]
    c[i] += a[i] + b[i]
    if c[i]>9
      c[i] = c[i]%10
      c[i+1] = 1
    end
  end
  c
end

def plus a, b
  (bigsum a.to_s.chars.map(&:to_i).reverse, b.to_s.chars.map(&:to_i).reverse).reverse.join
end

puts (bigsum [1,2,3,4,5,6], [1,2,3,4,5,6]).join
p '-=====================-'
puts plus "1234567890", "1234567890"
