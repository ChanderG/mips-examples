# Chander G - 30/07/14 
# 2.asm-- A program that finds GCD of any number of inputs 
# Registers used:
# t0 - used to hold the latest input
# t1 - used to hold the last number/gcd
# t2 - integer constant -1
# t3 - a flag for first round 
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

      # gcd in t1 , init w/ 1, integer const -1
      li $t1, 1
      li $t2, -1

      li $t3, 1

loop:
      # input in t0
      li $v0, 5
      syscall                   
      move $t0, $v0     

      beq $t0, $t2, end

      # if a number is entered, find gcd of it and the previous number 
      # a0-3 are used for passing function parameters
      beqz $t3, ever
      
      move $t1, $t0 
      li $t3, 0 
      
ever:
      move  $a1 ,$t1
      move  $a0 ,$t0

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
      li  $v0, 10    # system call code for exit = 10
      syscall        # call operating sys




gcd:  # standard algo for gcd -- result is stored in v0

      subu  $sp, $sp, 32  # Allocate a 32-byte stack frame
      sw  $ra, 20($sp)  # Save Return Address
      sw  $fp, 16($sp)  # Save old frame pointer
      addiu   $fp, $sp, 28  # Setup new frame pointer

      bgt $a0, $a1, gt
      beq $a0, $a1, eq
     
      # if a0 < a1 
      sub $a1, $a1, $a0
      jal gcd
      b done

gt:   # if a0 > a1 
      sub $a0, $a0, $a1
      jal gcd
      b done 

eq:   # if a0 == a1 
      move $v0, $a0 
      # li  $v0, 7 
      b done

done: lw  $ra, 20($sp)  # Restore return address
      lw  $fp, 16($sp)  # Restore frame pointer
      addiu   $sp, $sp, 32  # Pop stack
      jr $ra
