# Chander G - 30/07/14 
# 2.asm-- A program that finds GCD of any number of inputs 
# Registers used:
# t0 - used to hold the latest input
# t1 - used to hold the last number/gcd
# v0- syscall parameter.

  .data
input: .asciiz "Enter the numbers(-1 to exit): " 
newline: .asciiz "\n"
 
  .text
main: 
      # prompt for input
      la $a0,input
      li $v0, 4	
      syscall		

      # gcd in t1 , init w/ 1
      li $t1, 1

loop:
      # input in t0
      li $v0, 5
      syscall                   
      move $t0, $v0     

			li $t2, -1
      beq $t0, $t2, end

      # if a number is entered, find gcd of it and the previous number 
			# a0-3 are used for passing function parameters
			move $t1, $a1
      move $t0, $a0

      jal gcd

			# v0-1 are used to return from function
      move $t1, $v0

      move $a0, $t1
      li $v0, 1    	
      syscall

      la $a0,newline
      li $v0, 4	
      syscall		

      b loop
end:

      la $a0,newline
      li $v0, 4	
      syscall		

      li	$v0, 10		# system call code for exit = 10
			syscall				# call operating sys

gcd:  			
      li $t1, 1
			move $v0, $t1 

      jr $ra
