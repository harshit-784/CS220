.data 
    msg1: .asciiz "Specify the number of elements in the array: "
    msg2: .asciiz "Enter the values of the elements (one per line):\n"
    msg3: .asciiz "Enter the element you wish to seek: "
    foundmsg: .asciiz "The element is present in the array at the index:\n"
    notfoundmsg: .asciiz "The element is not present in the array.\n"
    array: .space  56                  # Assuming each element of the array is 4 bytes and max 12 elements

.text
main:
    # Prompt user for inputting the size of the array
    li   $v0, 4                         # system call code for printing message
    la   $a0, msg1
    syscall

    li   $v0, 5                         # system call code for reading integer
    syscall
    move $s0, $v0                       # store the entered integer (size of the array) in $s0

    la   $a0, msg2
    li   $v0, 4
    syscall

    la   $s1, array                     # load address of array into $s1

    # Loop to take inputs and store them in array
    move $t0, $s0                       # initialize counter i=n
input_loop:
    beqz $t0, done_input                # if (i==0) goto done_input

    li   $v0, 5                         # system call code for reading integer
    syscall                             # read an integer from keyboard to $v0
    sw   $v0, ($s1)                     # store the entered integer at $s1
    addi $s1, $s1, 4                    # move to the next location in array

    addi $t0, $t0, -1                   # decrement counter i
    j    input_loop                     # jump back to start of loop

done_input:
    # Prompt user for the key to search
    li   $v0, 4
    la   $a0, msg3
    syscall

    li   $v0, 5
    syscall
    move $s2, $v0                       # store the key to search in $s2

    # Call binary search function
    addi  $sp, $sp, -4                 
    move $a0, $s2                       # key
    li   $a1, 0                         # lower bound
    move $a2, $s0                       # upper bound (size of array - 1)
	addi $a2, $a2, -1
    la   $a3, array                     # array
    sw    $ra, 0($sp)                                   # push return address onto stack
    jal  binary_search
    lw    $ra, 0($sp)                                   # pop return address off stack


    # Check if element found or not
    beq  $v0, -1, element_not_found     # if $v0 == -1, element not found
    # Element found
    move $a1, $v0                       # index of the found element
    la $a0, foundmsg
    li   $v0, 4                         # system call code for printing integer
    syscall
    move $a0, $a1
    li $v0, 1
    syscall
    j    done

element_not_found:
    li   $v0, 4
    la   $a0, notfoundmsg
    syscall

done:
    li   $v0, 10                        # Exit
    syscall

# Binary search function
binary_search:
    # $a0: key, $a1: lower bound, $a2: upper bound, $a3: array
    sub  $t0, $a2, $a1
    bltz  $t0, not_found            # if lower bound > upper bound, element not found

    # Calculate mid
    srl  $t0, $t0, 1
    add  $t0, $a1, $t0


    # Load middle element
    addi  $t1, $t0, 0
	sll   $t1, $t1,  2                # Multiply by 4 to get offset in bytes
    add    $t1, $a3, $t1               # Add base address of array to offset
    lw   $t2, 0($t1)

    # Compare middle element with key
    beq  $t2, $a0, found                # if middle element == key, element found
    blt  $a0, $t2, left                  # if key < middle element, search left half
    addi $t0, $t0, 1                    # otherwise, search right half
    move  $a1, $t0                       #
    j    binary_search

left:
    # Search left half
    addi $a2, $t0, -1
    j    binary_search

found:
    # Element found, return index
    move $v0, $t0
    jr   $ra

not_found:
    # Element not found, return -1
    li   $v0, -1
    jr   $ra