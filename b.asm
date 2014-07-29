# Chander G - 26/07/14 
# b.asm-- Take an input and return sum of digits in the string 
# Registers used:
# t0 - used to hold the input
# t1 - used to store the result
# t2 - used to store the counter variable 
# t3 - used to store the current character
# t4 - used to store the intermediate value
# v0- syscall parameter.
 
  .data
input: .asciiz "Enter the input string: "
output1: .asciiz "The sum of the digits of the read input "
output2: .asciiz " is "
output3: .asciiz ".\n"

string_space : .space 104

  .text

main: # Prompt for an input   
      la $a0,input		# copy input prompt string location to a0  
      li $v0, 4   		# load immediate v0 with int const 4
      		     		# 4 - function code for printing strings 
      syscall

      # read in input to space string_space of max size 104
      # syscall code for reading string -- 8

      la $a0, string_space           
      li $a1, 104                  
      li $v0, 8                    
      syscall

      # init code
      # t2 holds pointer to string: initially at start of string 
      li $t1, 0
      la $t2, string_space

      # start of loop 
start_loop:

      # load byte at location stored in t2 into t3  
      lb $t3, ($t2)

      # loop until end of string
      # 10 stands for \n    
      beq $t3, 10, end_loop   
      
      # $t3 holds the current letter
      # if t3 < 0 or > 9 go to done 
      # 48 stands for 0
      # 57 stands for 9        
 
      bgt $t3, 57, done
      blt $t3, 48, done

      # get the integer and add it to the result  
      sub $t4, $t3, 48 
      addu $t1, $t1, $t4

done:

      # increment loop counter
      addu $t2, $t2, 1
      b start_loop

end_loop:

      # print result

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
