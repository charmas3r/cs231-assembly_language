# This programs reads 10 character from the user, stores them to an array, encrypts each character into
# a new array, outputs the encrypted string, then decrypts and outputs the original string. 
# Author @ Evan Smith
# Date: 3/7/18
# CSUSM CS231 Assembly Language 

.data		#start of the data

str1:   .asciiz "\nPlease enter the message that you want to send\n"
xMsg:	.asciiz "\nYour encrypted message is: \n"
Msg: 	.asciiz "\nYour decrypted message is: \n"
space:	.asciiz	"\n"
enter:	.byte	'-','-','-','-','-','-','-','-','-','-'
ncrypt:	.byte	'-','-','-','-','-','-','-','-','-','-'
output: .byte   '-','-','-','-','-','-','-','-','-','-' 

.text		

#start of the program

main:
	# encryption key
	li 	$s7, 10
	
	#user prompt
	li	$v0, 4
	la 	$a0, str1
	syscall

	#user may enter up to 10 chars to be saved in array 'enter'
	li 	$v0, 8
	la 	$a0, enter
	li 	$a1, 10
	syscall
	
	#newline
	li 	$v0, 4
	la 	$a0, space
	syscall	
	
	#load user input and ncrypt array to prepare for encryption
	#set counter for loop
	la 	$s2, enter
	la	$s1, ncrypt	
	li 	$t0, 10

xLoop:  #Loop runs for all elements in 10 char array
	beq     $t0, $0, print1
	lb 	$t1, 0($s2)
	#XOR encrypts the string using the key provided in first line of program
	xor 	$t2, $t1, $s7
	sb 	$t2, 0($s1)
	#clean memory
	li	$t2, 0
	li 	$t1, 0
	#go to next char in arrays and increase loop counter
	addi 	$s2, $s2, 1
	addi 	$s1, $s1, 1
	sub 	$t0, $t0, 1

	j 	xLoop

print1:
	#output encrypted message is:
	li	$v0, 4
	la 	$a0, xMsg
	syscall	
	
	#output encrypted user string
	li 	$v0, 4
	la 	$a0, ncrypt
	syscall

	#load arrays for decryption
	la 	$s2, ncrypt
	la	$s1, output
	
	#reset loop counter
	li	$t0, 10

dLoop:	#Loop runs for all elements in 10 char array
	beq     $t0, $0, print2
	lb 	$t1, 0($s2)
	#XOR now decrypts the string using the same key
	xor 	$t2, $t1, $s7
	sb 	$t2, 0($s1)
	#clean memory
	li	$t2, 0
	li 	$t1, 0
	#go to next char in arrays and increase loop counter
	addi 	$s2, $s2, 1
	addi 	$s1, $s1, 1
	sub 	$t0, $t0, 1

	j 	dLoop
		
print2:	#new;ine
	li 	$v0, 4
	la 	$a0, space
	syscall	

	#output decrcypt message
	li	$v0, 4
	la 	$a0, Msg
	syscall	
	
	#output decrypted user string
	li 	$v0, 4
	la 	$a0, output
	syscall
	
exit:	#end program
	li 	$v0, 10
	syscall