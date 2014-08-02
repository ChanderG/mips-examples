# Chander G - 30/07/14 
# 3.asm-- A program that  prints reverse of string
# Registers used:
# t0 - used to hold the latest input
# t1 - used to hold the last number/gcd
# t2 - integer constant -1
# t3 - a flag for first round 
# v0- syscall parameter.

  .data
input: .asciiz "Enter the string: " 
newline: .asciiz "\n"
string_space : .space 104

  .text
main: # Prompt for an input   
      la $a0,input		# copy input prompt string location to a0  
      li $v0, 4   		# load immediate v0 with int const 4
      		     		# 4 - function code for printing strings 
      syscall

      # read in input to space string_space of max size 104
      # syscall code for reading string -- 8

      la $a0, string_space           
      li $a1, 104                  
      li $v0, 8
      syscall                    

      la $a0, string_space
      li $v0, 4
      syscall

      # find loc of \n for ease 
      # a loop
      # t0 stands for curr string ctr
      # t1 stands for curr byte 
      # t2 stands for len

      la $t0, string_space
      li $t2, 1

loop:
      lb $t1, ($t0)
      beq $t1, 10, found
      addi $t0, $t0, 1 
      addi $t2, $t2, 1 
      b loop 
found:
      # use the address in t0 for end of string - maybe pass it as parameter
     

 
      # set up parameters here in a0-3       
      # param 1 - a0 - init addr of input
      # param 2 - a1 - effective len of string to be used for recursion


      move $a1, $t2 

      la $a0, string_space

      jal printreverse

      la $a0,newline
      li $v0, 4  
      syscall

      li  $v0, 10    # system call code for exit = 10
      syscall        # call operating sys





printreverse:

      subu  $sp, $sp, 32  # Allocate a 32-byte stack frame
      sw  $ra, 20($sp)  # Save Return Address
      sw  $fp, 16($sp)  # Save old frame pointer
      addiu   $fp, $sp, 28  # Setup new frame pointer

      # check for end case 
      li $t4, -1  
      beq $a1, $t4, done    

      addi $t5, $a1, -1   # num - 1        

      move $t6, $a0        
      add $t6, $t6, $a1
      lb $t7, ($t6) 

      # save a0 before
      move $t1, $a0

      # print char
      move $a0, $t7
      li $v0, 11 
      syscall

      move $a0, $t1      
      # call recursive  

      move $a1, $t5
      jal printreverse 

done: lw  $ra, 20($sp)  # Restore return address
      lw  $fp, 16($sp)  # Restore frame pointer
      addiu   $sp, $sp, 32  # Pop stack
      jr $ra
