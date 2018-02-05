#Program Description:	Program writter to mimic a very basic calculator
#Author: 		Evan Smith
#Creation Date:		02/02/2018

	.data
str1:	.asciiz "Please input the two numbers?\n"
str2:	.asciiz "\nSum is:"
str3:	.asciiz "\nDifference is:"
str4:	.asciiz "\nProduct is:"
str5:	.asciiz "\nQuotient is:"
str6:	.asciiz "\nRemainder is:"
	.text
main:
	li $v0, 4
	la $a0, str1
	syscall
	
	#input two numbers
	li $v0, 5
	syscall
	
	add $s0,$0,$v0
	
	li $v0, 5
	syscall
	
	add $s1,$0,$v0
	
	#perform math
	
	#add
	li $v0, 4
	la $a0, str2
	syscall
	
	add $t0, $s0, $s1
	add $a0, $t0, $0
	
	li $v0, 1
	syscall
	
	#subtract
	li $v0, 4
	la $a0, str3
	syscall
	
	sub $t0, $s0, $s1
	add $a0, $t0, $0
	
	li $v0, 1
	syscall
	
	#multi
	li $v0, 4
	la $a0, str4
	syscall
	
	mult $s0, $s1
	mflo $t1
	add $a0, $t1, $0
	
	li $v0, 1
	syscall
	
	#div
	li $v0, 4
	la $a0, str5
	syscall
	
	div $s0, $s1
	mflo $t0
	
	add $a0, $t0, $0
	
	li $v0, 1
	syscall
	
	#remainder
	li $v0, 4
	la $a0, str6
	syscall
	
	div $s0, $s1	
	mfhi $t0

	add $a0, $t0, $0
	
	li $v0, 1
	syscall
	
