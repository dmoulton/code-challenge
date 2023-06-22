def multiply_no_op(x, y)
    result = 0
    y.abs.times { result += x.abs }
    result = -result if (x.negative?) ^ (y.negative?)  
    result
end
  
def do_exp(base, exp)
    ans = 1
    exp.abs.times { ans = multiply_no_op(ans, base) }
    ans = 1.0 / ans if exp.negative?
    ans
end

unless ARGV[0] && 
        ARGV[1] && 
        Integer(ARGV[0], exception: false) && 
        Integer(ARGV[1], exception: false)
    puts "USAGE: ruby math.rb <num 1> <num 2>"
    exit
else
    x = ARGV[0].to_i
    y = ARGV[1].to_i
end

puts "#{x} * #{y} = #{multiply_no_op(x,y)}"

puts "#{x} ^ #{y} = #{do_exp(x,y)}"
