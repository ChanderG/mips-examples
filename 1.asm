# Chander G - 30/07/14 
# 1.asm-- A program that prints n terms of fibonacci series
# Registers used:
# t0 - used to hold the input
# t1 - used to hold flag of start
# t2 - used to hold a
# t3 - used to hold b
# t4 - used to hold c
# v0- syscall parameter.

# Based on a function that takes 2 parameters

  .data
input: .asciiz "Enter the number: " 
output1: .asciiz "\n"

  .text
main: # prompt for input
      la $a0,input
      li $v0, 4	
      syscall		

      # read in input to reg $t0  
      li $v0, 5
      syscall                   
      move $t0, $v0     

			li $t1, 1

      # 2 parameters, starting and number of calls left
      move $a0, $t0    # number of calls left
			move $a1, $t1    # inital flag
      jal printfib

      li	$v0, 10		# system call code for exit = 10
			syscall				# call operating sys

printfib:

			subu  $sp, $sp, 32  # Allocate a 32-byte stack frame
			sw  $ra, 20($sp)  # Save Return Address
			sw  $fp, 16($sp)  # Save old frame pointer
			addiu   $fp, $sp, 28  # Setup new frame pointer

      beqz $a0, done 

			beqz $a1, normal
      # print the initial 1's and move counter by 3  
      move $t5, $a0
      
			li $t1, 1 

			move $a0, $t1		
      li $v0, 1    	
      syscall

      # new line
      la $a0,output1
      li $v0, 4	
      syscall		

			move $a0, $t1		
      li $v0, 1    	
      syscall

      # new line
      la $a0,output1
      li $v0, 4	
      syscall		

      move $a2, $t1    # second last value
      move $a3, $t1    # last value
      li $t1, 0
			li $t4, 2
      sub $t5, $t5, $t4 
      move $a0, $t5    # number of calls left
			move $a1, $t1    # inital flag
      jal printfib

      b done
normal:
      # $a2 and $a3 hold previous times thing

      add $t4, $a2, $a3
     
		  move $t5, $a0
			li $t6, 1
      sub $t5, $t5, $t6 

      # print the number
			move $a0, $t4		
      li $v0, 1    	
      syscall

      # new line
      la $a0,output1
      li $v0, 4	
      syscall		

      move $a2, $a3 
      move $a3, $t4 
      move $a0, $t5    # number of calls left
			move $a1, $a1    # inital flag
      jal printfib


done: lw  $ra, 20($sp)  # Restore return address
			lw  $fp, 16($sp)  # Restore frame pointer
			addiu   $sp, $sp, 32  # Pop stack
			jr $ra
