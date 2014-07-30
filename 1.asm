# Chander G - 30/07/14 
# 1.asm-- A program that prints n terms of fibonacci series
# Registers used:
# t0 - used to hold the input
# t1 - used to hold loop counter 
# t2 - used to hold a
# t3 - used to hold b
# t4 - used to hold c
# v0- syscall parameter.
 
  .data
input: .asciiz "Enter the number: " 
output1: .asciiz "The sum of the digits of the read number "
output2: .asciiz " is "
output3: .asciiz ".\n"

  .text

main: # prompt for input 
      la $a0,input              
      li $v0, 4			
      syscall			

      # read in input to reg $t0  
      li $v0, 5     
      syscall                   
      move $t0, $v0   

      # store loop counter and initial values 
      li $t1, 0
      li $t2, 1
      li $t3, 1
compare:			# looping label

      beq $t1, $zero, equal	# if t3 == 0 , branch to label    
      
      divu $t3, $t2 		# divide t3 by t2 
				# t3 / 10

      # divu stores the quotient in lo and remainder in hi

      mfhi $a0			# copying remainder to a0 
      add $t1, $t1, $a0		# t1 += a0
      
      mflo $a0			# copying the quotient to a0 
      move $t3, $a0		# t3 = a0

      j compare			# jump to label compare 

equal:				# label following the loop 
      
      # print result

      la $a0,output1		# copy output1 string location to a0  
      li $v0, 4                 # load immediate v0 with int const 4
      syscall                   # 4 - function code for printing strings 

      # print the input 
      move $a0, $t0		# a0 = t0  
      li $v0, 1    		# load immediate v0 with int const 1
       		     		# 1 - function code for printing integers 
      syscall
      
      la $a0,output2 		# copy output2 string location to a0  
      li $v0, 4     		# load immediate v0 with int const 4
      syscall       		# 4 - function code for printing strings 

      # print the result
      move $a0, $t1		# a0 = t1 
      li $v0, 1    		# load immediate v0 with int const 1
      		      		# 1 - function code for printing integer 
      syscall

      la $a0,output3		# copy output3 string location to a0  
      li $v0, 4     		# load immediate v0 with int const 4
      syscall       		# 4 - function code for printing strings 

      jr $ra               # needed to finish smoothly
# end of add.asm
