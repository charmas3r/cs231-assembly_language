#Program Description:	Finds the factorial of a number between 1 and 10. 
#Author: 		Evan Smith
#Creation Date:		02/19/2018

	.data
str1:	.asciiz "Input a number: "
out1:	.asciiz "\n("
out2:   .asciiz "!) = "
out3:   .asciiz "test"
error:	.asciiz "\nERROR: Invalid number\n"
	.text
main:
	#ask the user to add a number.
	li $v0, 4
	la $a0, str1
	syscall
	
	#get user input
	li $v0, 5
	syscall
	
	#error check
	li $t0, 1
	li $t1, 10
	
	ble $v0, $t0, err
	bge $v0, $t1, err

	#store input to a register
	add $a0,$0,$v0
	add $t9, $0, $v0
	
	#set constants
	li $s7, 1
	
	jal fact
	
        #print output message
	li $v0, 4
	la $a0, out1
	syscall
	
	add $a0, $0, $t9	
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, out2
	syscall
	
	#output factorial number
	add $a0, $v1, $0
	li $v0, 1
	syscall
	
	j exit
	
	#subroutine to perform factorial algorithm
fact: 
	add $s0, $a0, $0
	
	add $t0, $s0, $0 # t0 = 5
	
	sub $t0, $t0, 1 # t0 = 4
	
	j loop
	
       #stop loop once n = 1
loop:  beq $t0, $s7, exitL
        
       mult $s0, $t0
       mflo $t2
	
       add $s0, $t2, $0 #store result into #s0
      		
       sub $t0, $t0, 1 #t0 = 3	

       j loop
	
exitL:
	add $v1, $s0, $0
	jr $ra
										
	
exit:	#end program
	li $v0, 10
	syscall
	
err:	
	#print error message
	li $v0, 4
	la $a0, error
	syscall
	
	j main
