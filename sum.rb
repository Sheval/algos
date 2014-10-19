#stack test

def sum x
  begin
    x<=0 ? 0 : sum(x-1)+1
  rescue SystemStackError
    puts "Stack overflow on #{$*[0].to_i-x} calls"
    0
  end
end

puts "Input values #{$*}"
puts sum($*[0].to_i) if $*.any?
