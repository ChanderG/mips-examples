# Chander G - 26/07/14 
# b.asm-- Question 2 
# Registers used:
# t0 - used to hold the input
# t1 - used to store the result
# t2 - used to store the counter variable 
# t3 - used to store the current character
# t4 - used to store the intermediate value
# v0- syscall parameter.
 
  .data
output1: .asciiz "The sum of the digits of the read input "
output2: .asciiz " is "
output3: .asciiz ".\n"

string_space : .space 1024

	.text

main:  

      # read in input to reg $t0
      la $a0, string_space           # location where input will be stored 
      li $a1, 1024                   # max size of input
			li $v0, 8                      # syscall code for reading string
      syscall

      #calculate and store result in $t1
      li $t1, 0
			la $t2, string_space
			b start_loop 
start_loop:
      lb $t3, ($t2)
      beq $t3, 10, end_loop   # using \n to end string
			
      # Do the computation here
			# $t3 holds the current letter
      
			bgt $t3, 57, done
			blt $t3, 48, done

			sub $t4, $t3, 48 
			addu $t1, $t1, $t4

done:
      addu $t2, $t2, 1
			b start_loop
			
			# print result
end_loop:

      la $a0,output1
      li $v0, 4
			syscall

	    la $a0,string_space
      li $v0, 4
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
