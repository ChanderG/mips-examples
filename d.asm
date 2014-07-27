# Chander G - 26/07/14 
# d.asm -> question 4  
# Registers used:
# t0 - used to hold the input
# t3 - used to hold the working copy 
# t4 - used to hold the number of label
# v0- syscall parameter.
 
# TODO:  space at the end

  .data
output0: .asciiz "Zero " 
output1: .asciiz "One " 
output2: .asciiz "Two "
output3: .asciiz "Three "
output4: .asciiz "Four "
output5: .asciiz "Five "
output6: .asciiz "Six "
output7: .asciiz "Seven "
output8: .asciiz "Eight "
output9: .asciiz "Nine "


	.text

main:  # read in input to reg $t0
			li $v0, 5           
			syscall
			move $t0, $v0
 
      # is number positive
      blt $t0, $zero, done

      # if so: get the digits

      li $t2, 10 
      move $t3, $t0 

compare:
      beq $t3, $zero, end 

			divu $t3, $t2 

			mfhi $a0
		  # print the current digit	
			
      li $t4, 0
      beq $a0, $t4 , zero

      li $t4, 1
      beq $a0, $t4 , one

      li $t4, 2
      beq $a0, $t4 , two

      li $t4, 3
      beq $a0, $t4 , three

      li $t4, 4
      beq $a0, $t4 , four

      li $t4, 5
      beq $a0, $t4 , five

      li $t4, 6
      beq $a0, $t4 , six

      li $t4, 7
      beq $a0, $t4 , seven

      li $t4, 8
      beq $a0, $t4 , eight

      li $t4, 9
      beq $a0, $t4 , nine

zero:  
      la $a0,output0
      li $v0, 4
			syscall
      b end

one:  
      la $a0,output1
      li $v0, 4
			syscall
      b end

two:  
      la $a0,output2
      li $v0, 4
			syscall
      b end

three:  
      la $a0,output3
      li $v0, 4
			syscall
      b end

four:  
      la $a0,output4
      li $v0, 4
			syscall
      b end

five:  
      la $a0,output5
      li $v0, 4
			syscall
      b end

six:  
      la $a0,output6
      li $v0, 4
			syscall
      b end

seven:  
      la $a0,output7
      li $v0, 4
			syscall
      b end

eight:  
      la $a0,output8
      li $v0, 4
			syscall
      b end

nine:  
      la $a0,output9
      li $v0, 4
			syscall
      b end

end:
			mflo $a0
      move $t3, $a0

      b compare

done:
			jr $ra               # needed to finish smoothly
# end of add.asm
