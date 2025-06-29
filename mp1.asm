%include "io64.inc"

section .bss
    mCol resw 1
    nRow resw 1
    totalSizeMatrix resq 1
    array1 resq 100
    array2 resq 100
    result resq 100

section .text
global CMAIN

CMAIN:
        
   GET_DEC 2, [mCol]
   GET_DEC 2, [nRow]
   
   ; Calculate the total size of the matrix
   MOVZX rax, word [mCol]
   MOVZX rbx, word [nRow]
   IMUL rax, rbx
   MOV [totalSizeMatrix], rax
   
   
   ; Transfer to rcx for looping purposes
   MOV rcx, [totalSizeMatrix]
   
   ; Read the first matrix
   MOV rsi, array1
        
  
   .read_array1: 
       ; get the inputs
       GET_DEC 2, ax
       MOVZX rax, ax ; move with zero extension
       MOV [rsi], rax ; copy to the address of rsi
                       ; to move the pointer
       ADD rsi, 8 ; move the pointer by the its size
       DEC rcx ; decrement the counter
       JNZ .read_array1 
   
   ; copy the total size again to rcx for counter later
   MOV rcx, [totalSizeMatrix]
   MOV rsi, array2 ; move the rsi to the array for storing
    
    
   .read_array2:
        ; same process as the read_array1 
        GET_DEC 2, ax
        MOVZX rax, ax
        MOV [rsi], rax
        ADD rsi, 8
        DEC rcx
        JNZ .read_array2
        
        ;copy total size again
        MOV rcx, [totalSizeMatrix]
        
        ;move the rsi back to array 1
        MOV rsi, array1
        ;move the rdi to array 2
        MOV rdi, array2
        ;pointer to result for storing
        MOV rdx, result
        
   .add_matrices:
        ; the contents to rax then add the data in rdi
        MOV rax, [rsi]
        ADD rax, [rdi]
        MOV [rdx], rax ; move the sum to the results
        
        ; update the positions
        ADD rsi, 8
        ADD rdi, 8
        ADD rdx, 8
        
        ; decrement counter then loop
        DEC rcx
        JNZ .add_matrices
   
   ; size of the row
   MOVZX rcx,  word [nRow]
   ; pointer to array for printing
   MOV rdx, result
        

  .print_rows:
        ; push the new rcx size for new lines
        PUSH rcx
        ; new size base on column
        MOVZX rcx, word [mCol]
        
  .print_columns:
        ;print the contents in the results
        MOV rax, [rdx]
        PRINT_DEC 2, rax
        PRINT_STRING " "
        ; move pointe and update loop counter
        ADD rdx, 8
        DEC rcx
        JNZ .print_columns
        
        ; update values
        NEWLINE
        POP rcx
        DEC rcx
        JNZ .print_rows
        
   xor rax, rax
   ret
    
 

    
       