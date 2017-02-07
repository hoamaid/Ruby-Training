a = 5
b = 2
c = 3

if b < a
	print "b is less than a"
elsif a == b
	print "a is equal to b"
else
	print "b is greater than a"
end

x = c < a
unless x
	puts "c > a"
end

puts "b > c" unless b < c

puts " Done!"


# test_1 should be true
test_1 = 3 > 1 && 2 < 4

# test_2 = should be true
test_2 = 5 < 6 || 7 > 1

# test_3 = should be false
test_3 = !(2 > 1) && 5 < 8