#Program Description:	Practice with arrays. Outputting an array of user entered integers in reverse order
#Author: 		Evan Smith
#Creation Date:		02/12/2018

	.data
arr1:   .word	0,0,0,0,0,0,0,0,0,0
str1:	.asciiz "Enter the number of elements:\n"
str2:	.asciiz "\nThe content of the array in reverse order is: \n"
str3: 	.asciiz "\n================================================\n"
str4:   .asciiz "\nEnter number "
str5:   .asciiz "\n"
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
	
	#store constant of 1
	li $t2, 1
	
	#store constant of 10
	li $t3, 10
	
	#check to see if first number is less than 1
	ble $s0, $t2, err_1
	
	#check to see if first number is less than 1
	bge $s0, $t3, err_2
	
	#create counters from the user input
	add $s3,$s0,$0
	add $s4, $s0, $0
	
	#declare array length and memory register for first element
	la $s2, arr1
	
	#starting number counter
	li $s1, 1
	li $t4, 10
	 
	#print header string
	li $v0, 4
	la $a0, str3
	syscall
	
	#check counter in loop to exit
loop1:	beq $s3, $0, revM

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
	add $t0, $v0, $0
	
	#input number into the array
	sw $t0, 0($s2)
	
	#increment counter and array slot (by 4 to point to next position)
	add $s1, $s1, 1
 	add $s2, $s2, 4
	add $s3, $s3, -1
	j loop1

revM:  	
	#print header string
	li $v0, 4
	la $a0, str3
	syscall
	
	#output message
	li $v0, 4
	la $a0, str2
	syscall
	
	#print header string
	li $v0, 4
	la $a0, str3
	syscall
	
	j loop2
			
	#check counter in loop to exit
loop2:	beq $s4, $0, exit

	#decrement counter
	add $s2, $s2, -4
	
	#output last number in the array	
	lw $a0, 0($s2)
	
	li $v0, 1
	syscall
	
	#go to next line
	li $v0, 4
	la $a0, str5
	syscall
	
	#decrement counter and array slot (by 4 to point to next position)
	add $s4, $s4, -1
	j loop2
	
exit:   
	#print header string
	li $v0, 4
	la $a0, str3
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
	
	
