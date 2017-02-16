#Here I define my method follow by the nth input
def myfibonacci(n)
    a = 0
    b = 1
	c = a + b
	
#Here I am telling the program to loop nth times
	n.times do
	c = a
	a = b
	b = c + b
end

puts a

end

#Here I iterate/loop 100 times
100.times do |n|
    answer = myfibonacci(n)
    print answer
end


