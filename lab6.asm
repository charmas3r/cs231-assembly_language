#Program Description:	Convert decimal number to binary
#Author: 		Evan Smith
#Creation Date:		02/21/2018

	.data
in:	.asciiz "Input a number in decimal form:       "
out1:   .asciiz "\nThe number "

test:   .asciiz "\nTest"

out2:   .asciiz " in binary form is:                   "
	.text
main:
	#ask the user to enter a number
	li $v0, 4
	la $a0, in
	syscall
	
	#get user input
	li $v0, 5
	syscall
	
	#add contents
	add $a0, $0, $v0
	add $s0, $0, $v0
	
	jal decToBin
	
	#end program
	li $v0, 10
	syscall
	
	#subroutine to perform factorial algorithm
decToBin: 

	#store dec to t0
	add $t0, $0, $a0

	#set constants
	li $s1, 32
	li $s2, 2
	 
	#initilze zero counter
	li $s3, 0
	
	#print output message
	li $v0, 4
	la $a0, out1
	syscall
	
	add $a0, $0, $s0		
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, out2
	syscall	
		
	# continue to divide until quotient eqauls 0
	loop1:	beq $t0, $0, prnt0
		
		
		#divide by 2 and store quotient and remainder
		div $t0, $s2
		mfhi $t1
		mflo $t0
		
		#move stack pointer to first insert position
		addi $sp, $sp, -4
		
		#insert quotient into stack
		sw $t1, 0($sp)
		
		#start counter for zero adding
		add $s3, $s3, 1
		add $s4, $s4, 1
		
		j loop1
		
	prnt0:	beq $s1, $s3, printS
										
		#print zero for each leading 0
		li $a0, 0
		li $v0, 1
		syscall
		
		#increment zero counter
		add $s3, $s3, 1
		
		j prnt0
		
	printS:	beq $s4, $0, exit
	
		#pop and print number
		lw $a0, 0($sp)
		li $v0, 1
		syscall
		
		addi $sp, $sp, 4
	
		sub $s4, $s4, 1
		
		j printS
			
	exit: 	jr $ra							

