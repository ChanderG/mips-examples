# Chander G - 26/07/14 
# b.asm-- Question 2 
# Registers used:
# t0 - used to hold the input
# v0- syscall parameter.
 
  .data
output1: .asciiz "The sum of the digits of the read input "
output2: .asciiz " is "
output3: .asciiz ".\n"

	.text

main:  

      # read in input to reg $t0
			li $v0, 5           
			syscall
			move $t0, $v0

      #calculate and store result in $t1
      
			
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
