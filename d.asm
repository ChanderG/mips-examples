# Chander G - 26/07/14 
# d.asm -> question 4  
# Registers used:
# t0 - used to hold the input
# t3 - used to hold the working copy 
# t4 - used to hold the number of label
# t5 - used to store starting stack pointer 
# v0- syscall parameter.
 
# TODO:  space at the end

  .data
input: .asciiz "Enter a positive number: " 
scold: .asciiz "Read the instructions carefully.\n" 
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

main: # prompt for input  
      la $a0,input
      li $v0, 4
      syscall

      # read in input to reg $t0
      li $v0, 5           
      syscall
      move $t0, $v0
 
      # is number positive
      blt $t0, $zero, ndone

      # if so: get the digits

      # init
      li $t2, 10 
      la $t5, ($sp) 
      move $t3, $t0 

      # basically push digits in reverse order
compare:
      beq $t3, $zero, pop 

      divu $t3, $t2 

      mfhi $a0

      # push digit onto the stack 
      addi $sp, $sp, -4  # Decrement stack pointer by 4
      sw   $a0, 0($sp)   # Save $r3 to stack
     
 
      mflo $a0
      move $t3, $a0
      b compare

pop:  # pop number from stack and look up the string
      beq $sp, $t5, end     
      
        
      lw   $t4, 0($sp)   # Copy from stack to $r3
      addi $sp, $sp, 4   # Increment stack pointer by 4
  
      move $a0, $t4
      #li $v0, 1
      #syscall


      # compare with integers and jump to coresponding label 
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

      # labels corresponding to the digits

zero:  
      la $a0,output0
      li $v0, 4
      syscall
      b pop

one:  
      la $a0,output1
      li $v0, 4
      syscall
      b pop

two:  
      la $a0,output2
      li $v0, 4
      syscall
      b pop

three:  
      la $a0,output3
      li $v0, 4
      syscall
      b pop

four:  
      la $a0,output4
      li $v0, 4
      syscall
      b pop

five:  
      la $a0,output5
      li $v0, 4
      syscall
      b pop

six:  
      la $a0,output6
      li $v0, 4
      syscall
      b pop

seven:  
      la $a0,output7
      li $v0, 4
      syscall
      b pop

eight:  
      la $a0,output8
      li $v0, 4
      syscall
      b pop

nine:  
      la $a0,output9
      li $v0, 4
      syscall
      b pop


      # when a negative number is input 
ndone:
      # scold user for not following instructions
      la $a0,scold
      li $v0, 4
      syscall

end:
done:
      jr $ra               # needed to finish smoothly
# end of add.asm
