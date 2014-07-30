# ChanderG - chandergovind@gmail.com - 30/07/14
# Sample program with functions 

  .data
input: .asciiz "Enter the number: " 

  .text
main: 
      # get input
      jal inp       # jump and link

      # print the result
      move $a0, $t0
      li $v0, 1    	
      syscall

      li	$v0, 10		# system call code for exit = 10
			syscall				# call operating sys

inp:
      la $a0,input
      li $v0, 4	
      syscall		

      # read in input to reg $t0  
      li $v0, 5
      syscall                   
      move $t0, $v0     

      jr $ra     # jump and return to the return address 
