# Chander G - 29/07/14 
# e.asm-- question 5 : find if input is a perfect number 
# Registers used:
# t0 - used to hold the input 1
# t1 - used to hold the input 2
# t2 - used to hold the input 3
# t3 - used to hold the output
# t4 - used to hold the smallest of the 3 inputs 
# v0- syscall parameter.
 
  .data
input: .asciiz "Enter the input: "  
output1: .asciiz "The number is perfect.\n"
output2: .asciiz "The number is not perfect.\n"

  .text

main: # prompt user input  
      la $a0,input
      li $v0, 4
      syscall

      # read in input to the register v0
      li $v0, 5           
      syscall

      # push digit onto the stack 
      addi $sp, $sp, -4  # Decrement stack pointer by 4
      sw   $v0, 0($sp)   # Save input to stack

      #Check for perfect number property
      li $t0, 1    # loop counter in register
 	
	    li $t1, 0    # one off initial value of sum
      # calculated sum on the stack
      addi $sp, $sp, -4  # Decrement stack pointer by 4
      sw   $t1, 0($sp)   # save sum on stack

start:
      # Check if t0 is a factor 
			lw $t1, 4($sp)

		  beq $t0, $t1, done

      divu $t1, $t0

			mfhi $t2
			bne $t2, $zero, con

      lw $t3, ($sp)
			add $t4, $t3, $t0
			sw $t4, 0($sp)

con:
			addi $t0, $t0, 1

      b start
done:
      # compare for equality 
			lw $t1, 4($sp)
			lw $t2, 0($sp)

      beq $t1, $t2, p

      # print not perfect
      la $a0,output2
      li $v0, 4
      syscall
			b end

p: 
      # print perfect
      la $a0,output1
      li $v0, 4
      syscall

end:
      jr $ra               # needed to finish smoothly
# end of e.asm
