#Program Description:	Practice with arrays. Outputting an array of user entered integers in reverse order
#Author: 		Evan Smith
#Creation Date:		02/12/2018

	.data
arr1:   .word	0,0,0,0,0,0,0,0,0,0,0
str1:	.asciiz "Enter the number of elements:\n"
str3: 	.asciiz "\n================================================\n"
str4:   .asciiz "\nEnter number "
str5:   .asciiz "\n The median is: "
str6:   .asciiz ": "
error0:	.asciiz "\nERROR: Array can't have less than 1 element, try again!!\n"
error1:	.asciiz "\nERROR: Array can't have more than 10 elements, try again!!\n"
	.text
	
main:	#ask the user how many numbers they want to add to array.
	li $v0, 4
	la $a0, str1
	syscall
	
	#input user number
	li $v0, 5
	syscall	
	
	#store input to a register
	add $s0,$0,$v0
	
	#store constants
	li $t0, 11
	li $t3, 2
	li $t1, 4
	
	#check to see if first number is less than 1
	ble $s0, $0, err_1
	
	#check to see if first number is less than 1
	bge $s0, $t0, err_2
	
	#create counters from the user input
	add $s3,$s0,$0
	
	#declare array length and memory register for first element
	la $s2, arr1
	
	#starting number counter
	li $s1, 1
	li $s4, 0
	 
	#print header string
	li $v0, 4
	la $a0, str3
	syscall
	
	#check counter in loop to exit
loop1:	beq $s3, $0, divM

	#ask user to input new number	
	li $v0, 4
	la $a0, str4
	syscall
	
	#output "x: " after "Enter Number" string
	add $a0, $s1, $0
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, str6
	syscall
	
	li $v0, 5
	syscall
	
	#store user input
	add $t2, $v0, $0
	
	#input number into the array
	sw $t2, 0($s2)
	
	#increment counter and array slot (by 4 to point to next position)
	add $s1, $s1, 1
	add $s4, $s4, 1
 	add $s2, $s2, 4
	add $s3, $s3, -1
	j loop1

			
	
divM:	# perform division and store quotient and remainder
	div $s4, $t3
	mflo $t4
	mfhi $t5
	
	#parity checking
	beq $t5, $0, even
	j odd
	
even:	#if even..
	mult $t4, $t1
	mflo $t6

	#print header string
	li $v0, 4
	la $a0, str3
	syscall
	
	#print output string
	li $v0, 4
	la $a0, str5
	syscall

	#declare array length and memory register for first element
	la $s2, arr1
		
	add $s2, $s2, $t6
		
	#store first element	
	lw $s5, 0($s2)
	
	#go to element behind current
	add $s2, $s2, -4
	
	#store second
	lw $s6, 0($s2)
	
	#get sum of two elements
	add $s7, $s5, $s6
	
	#divide by 2
	div $s7, $t3
	mflo $t7
	
	add $a0, $t7, $0
	
	j exit
	
	#if odd..
odd:	mult $t4, $t1
	mflo $t6

	#print header string
	li $v0, 4
	la $a0, str3
	syscall
	
	#print output string
	li $v0, 4
	la $a0, str5
	syscall

	#declare array length and memory register for first element
	la $s2, arr1
		
	add $s2, $s2, $t6
		
	#output median element of odd indexed array	
	lw $a0, 0($s2)
	
	j exit
	
exit:   	
	li $v0, 1
	syscall
		
	#end program
	li $v0, 10
	syscall

	
	#error message for if number is lnegative
err_1:  li $v0, 4
	la $a0, error0
	syscall
	
	j main
	
	#error message for if number is less than 1
err_2:  li $v0, 4
	la $a0, error1
	syscall
	
	j main
	
	
