# Chander G - 26/07/14 
# add.asm-- A program that computes the sum of 1 and 2,
# leaving the result in register $t0.
# Registers used:
# t0 - used to hold the input
# t1 - used to hold the constant 1.
# v0- syscall parameter.
 
  .data
output1: .asciiz "The sum of "
output2: .asciiz " is "
output3: .asciiz ".\n"

	.text

main:  
      # li $t1, 1
      # add $t0, $t1, 2 # put it into $t0.
      # li $v0, 10 
			# syscall 

      # read in input to reg $t0
			li $v0, 5           
			syscall
			move $t0, $v0

      #calculate and store result in $t1
      li $t1, -1 

      li $t2, 10 
			divu $t0, $t2 

			mfhi $a0
			li $v0, 1
			syscall
			
			mflo $a0
			li $v0, 1
			syscall

      # print result

      la $a0,output1
      li $v0, 4
			syscall

			move $a0, $t0
			li $v0, 1
			syscall

      la $a0,output2
      li $v0, 4
			syscall

			move $a0, $t1
			li $v0, 1
			syscall

      la $a0,output3
      li $v0, 4
			syscall

			jr $ra               # needed to finish smoothly
# end of add.asm