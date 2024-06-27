.data
    inp_prompt: .asciiz "Enter number of values: "
    vec_prompt: .asciiz "Enter value: \n"
    result_prompt: .asciiz "Result: "

.text
.globl main
main:
    # Print prompt for number of values
    li $v0, 4
    la $a0, inp_prompt
    syscall

    # Read number of values
    li $v0, 5
    syscall
    move $t0, $v0

    # set flag to 0
    li $t1, 0

    # Print prompt for vector
    la $a0, vec_prompt
    li $v0, 4
    syscall

    # Initialize sum to 0
    li.s $f1, 0.0

    # Read values of vector
    loop:
        bge $t2, $t0, result   # if i >= n, exit loop 

        # Read float value
        li $v0, 6
        syscall

        # Decide to add or subtract
        beqz $t1, add_next
        sub.s $f1, $f1, $f0
        j continue_exec
        add_next:
            add.s $f1, $f1, $f0
    
        continue_exec:
            # Change flag
            xori $t1, $t1, 1
            # Increment i
            addi $t2, $t2, 1
            j loop
    
    result:
        # Print result
        li $v0, 4
        la $a0, result_prompt
        syscall

        # Print the final value
        li $v0, 2
        mov.s $f12, $f1
        syscall

        # Exit
        li $v0, 10
        syscall
