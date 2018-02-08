#Program Description:	Adds numbers together using a loop
#Author: 		Evan Smith
#Creation Date:		02/05/2018

	.data
str1:	.asciiz "How many positive numbers devisibly by 6 would you like to add?\n"
str2:	.asciiz "\nEnter a number:  "
sum:	.asciiz "\nThe sum is: "
error0:	.asciiz "\nERROR: MUST BE POSITIVE NUMBER. ENTER ANOTHER NUMBER \n"
error1:	.asciiz "\nERROR: NUMBER NOT IN RANGE. ENTER ANOTHER NUMBER \n"
error2:	.asciiz "\nERROR: NUMBER NOT DIVISIBLE BY 6. ENTER ANOTHER NUMBER \n"
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
	
	#check to see if first number is negative
	ble $s0, $0, errorM
	
	#create a counter from the user input
	add $s3,$s0,$0
	
	#store constant of 1
	li $t2, 1
	
	#store constant of 100
	li $t3, 100
	
	#check counter in loop to exit
loop:	beq $s3, $0, exit

	#input new number	
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 5
	syscall
	
	#store user input
	add $s2, $v0, $0
	
	#outer loop [ check to see if number < 1 ]
	blt $s2, $t2, err_1
	
	#outer loop [ check to see if number > 100 ]
	bge $s2, $t3, err_1
	
	#store constant of 6 for upcoming divisibility checking
	li $t0, 6
	
	#div to get a remainder
	div $s2, $t0	
	mfhi $t1
	
	#check if number is not divisible by 6
	bne $0, $t1, err_2
	
	#if number is divisible by 6 then add to sum
 	add $s1, $s2, $s1
	addi $s3, $s3, -1
	j loop
	
exit: 	li $v0, 4
	la $a0, sum
	syscall
	
	#print even sum integer
	add $a0, $s1, $0
	
	li $v0, 1
	syscall
	
	#end program
	li $v0, 10
	syscall
	
	#error message for if number is lnegative
errorM: li $v0, 4
	la $a0, error0
	syscall
	
	j main
	
	#error message for if number is less than 1
err_1:  li $v0, 4
	la $a0, error1
	syscall
	
	j loop
	
	#error message for if number is greater than 100
err_2:  li $v0, 4
	la $a0, error2
	syscall
	
	j loop
	
