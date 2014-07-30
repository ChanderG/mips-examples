# Chander G - 30/07/14 
# 1.asm-- A program that prints n terms of fibonacci series
# Registers used:
# t0 - used to hold the input
# t1 - used to hold loop counter 
# t2 - used to hold a
# t3 - used to hold b
# t4 - used to hold c
# v0- syscall parameter.

# Based on a function that takes 2 parameters

  .data
input: .asciiz "Enter the number: " 
output1: .asciiz "The sum of the digits of the read number "
output2: .asciiz " is "
output3: .asciiz ".\n"

  .text
main: 
      # get input
      jal inp       # jump and link

      # print the result
      lw $t1, ($sp) 

      move $a0, $t1
      li $v0, 1    	
      syscall

      li	$v0, 10		# system call code for exit = 10
			syscall				# call operating sys

inp:
      la $a0,input
      li $v0, 4	
      syscall		

      # read in input to reg $t0  
      li $v0, 5
      syscall                   
      move $t0, $v0     

      addi $sp, $sp, -4
      sw $t0, ($sp) 

      jr $ra     # jump and return to the return address 
