#Program Description:	Converts Celsius integer to Farenheit floating point number and prints the result.
#Author: 		Evan Smith
#Creation Date:		03/03/2018

	.data

in:       .asciiz "\nPlease input a number in Celsius: "
out:      .asciiz "\nThe temperature in Farenheit is: "
const:    .float   1.8
const2:   .float   32.0

	.text
main:
	
	#ask the user to enter a number
	li $v0, 4
	la $a0, in
	syscall
	
	#get user input
	li $v0, 5
	syscall

	#store input for conversion function
	add $s0, $v0, $0
	
	#convert user input to floating point number
	mtc1 $s0, $f1
	cvt.s.w $f1, $f1
	
	#perform arithmitic conversion
	# F = C * 1.8 + 32
	
	#load 1.8 into f2
	l.s $f2, const
	
	#multiply float input by 1.8
	mul.s $f3, $f1, $f2
	
	#add 32
	l.s $f4, const2
	add.s $f3, $f3, $f4
	
	#Farenheit now stored in f3
	
	#ask the user to enter a number
	li $v0, 4
	la $a0, out
	syscall
	
	#print Farenheit
	li $v0, 2
	mov.s $f12, $f3
	syscall
	
	#terminate program
	li $v0, 10
	syscall	
	
	
	
