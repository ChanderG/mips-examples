# Chander G - 26/07/14 
# c.asm-- question 3  
# Registers used:
# t0 - used to hold the input 1
# t1 - used to hold the input 2
# t2 - used to hold the input 3
# t3 - used to hold the output
# t4 - used to hold the smallest of the 3 inputs 
# v0- syscall parameter.
 
  .data
input: .asciiz "Enter the three numbers: "	
output1: .asciiz "The sum of the larger 2 of the read numbers is: "
output2: .asciiz ".\n"

	.text

main: # prompt user input  
      la $a0,input
      li $v0, 4
			syscall

      # read in input to reg $t0
			li $v0, 5           
			syscall
			move $t0, $v0

      # read in input to reg $t1
			li $v0, 5           
			syscall
			move $t1, $v0

      # read in input to reg $t2
			li $v0, 5           
			syscall
			move $t2, $v0

      #calculate and store result in $t3

			# store the sum of all three first
      add $t3, $t0, $t1
      add $t3, $t3, $t2

			# find smallest

      move $t4, $t0

			bgt $t4, $t1, one
			b continue

one:
      move $t4, $t1
continue:
			bgt $t4, $t2, two
      b continue_2

two:
      move $t4, $t2
continue_2:
      sub $t3, $t3, $t4 

      # print output
      la $a0,output1
      li $v0, 4
			syscall

			move $a0, $t3
			li $v0, 1
			syscall

      la $a0,output2
      li $v0, 4
			syscall

			jr $ra               # needed to finish smoothly
# end of add.asm
