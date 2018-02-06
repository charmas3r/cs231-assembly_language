#Program Description:	Adds numbers together using a loop
#Author: 		Evan Smith
#Creation Date:		02/05/2018

	.data
str1:	.asciiz "How many numbers would you like to add together?\n"
str2:	.asciiz "The sum of the even numbers are "
	.text
main:
	#ask the user how many numbers they want to add.
	li $v0, 4
	la $a0, str1
	syscall
	
	#input first number
	li $v0, 5
	syscall
	
	#store input to a register
	add $s0,$0,$v0
	
	#create a counter from the user input
	add $s3,$s0,$0
	
	#outer loop [ check counter against zero ]
loop:	beq $s3, $0, exit
	
	#input number
	li $v0, 5
	syscall
	
	#store user input
	add $s2, $v0, $0
	
	#store constant of 2 for upcoming parity checking
	li $t0, 2
	
	#div to get a remainder
	div $s2, $t0	
	mfhi $t1
	
	#check if number is even or odd
	beq $0, $t1, sum
	
	#if odd then decrement and go back to beginning
	addi $s3, $s3, -1
	j loop

	#if even add to sum, decrement counter and loop
sum: 	add $s1, $s2, $s1
	addi $s3, $s3, -1
	j loop
	
exit: 	
	li $v0, 4
	la $a0, str2
	syscall
	
	#print even sum integer
	add $a0, $s1, $0
	
	li $v0, 1
	syscall
	
	#end program
	li $v0, 10
	syscall
	
