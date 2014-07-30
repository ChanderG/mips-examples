# ChanderG - chandergovind@gmail.com - 30/07/14
# Sample program with functions 

  .data
input: .asciiz "Enter the number: " 

  .text

main: #li $t0, 7 
      # addi $sp, $sp, -4
      # sw $t0, ($sp) 
	    
      # get input
      jal inp       # jump and link

      # print the result
      lw $t1, ($sp) 

      move $a0, $t1
      li $v0, 1    	
      syscall

      li	$v0, 10		# system call code for exit = 10
			syscall				# call operating sys

inp:  #lw $t1, ($sp)
      #move $a0, $t1
      #li $v0, 1    	
      #syscall

      la $a0,input
      li $v0, 4	
      syscall		

      # read in input to reg $t0  
      li $v0, 5
      syscall                   
      move $t0, $v0     

      addi $sp, $sp, -4
      sw $t0, ($sp) 

      jr $ra     # jump and return to the return address 
