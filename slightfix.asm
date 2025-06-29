; Chu, Andre
; De Jesus, Andrei



%include "io64.inc"

section .bss
    mCol resd 1      ; Use DWORD for dimensions
    nRow resd 1
    totalSizeMatrix resq 1
    array1 resd 100  ; Use DWORD for elements
    array2 resd 100
    result resd 100

section .text
global CMAIN

CMAIN:
    ; Read dimensions (mCol, nRow)
    GET_DEC 4, [mCol]
    GET_DEC 4, [nRow]

    ; Calculate total elements
    MOV eax, [mCol]
    IMUL eax, [nRow]
    MOV [totalSizeMatrix], rax

    ; Read Matrix 1
    MOV rsi, array1
    MOV rcx, [totalSizeMatrix]
.read_array1:
    GET_DEC 4, eax
    MOV [rsi], eax
    ADD rsi, 4
    DEC rcx
    JNZ .read_array1

    ; Read Matrix 2
    MOV rsi, array2
    MOV rcx, [totalSizeMatrix]
.read_array2:
    GET_DEC 4, eax
    MOV [rsi], eax
    ADD rsi, 4
    DEC rcx
    JNZ .read_array2

    ; Add matrices
    MOV rsi, array1
    MOV rdi, array2
    MOV rdx, result
    MOV rcx, [totalSizeMatrix]
.add_matrices:
    MOV eax, [rsi]
    ADD eax, [rdi]
    MOV [rdx], eax
    ADD rsi, 4
    ADD rdi, 4
    ADD rdx, 4
    DEC rcx
    JNZ .add_matrices

    ; Print result
    MOV ecx, [nRow]      ; Rows counter
    MOV rdx, result
.print_rows:
    MOV ebx, [mCol]      ; Columns counter
.print_columns:
    MOV eax, [rdx]
    PRINT_DEC 4, eax
    ADD rdx, 4
    DEC ebx
    JZ .skip_space
    PRINT_STRING " "
.skip_space:
    JNZ .print_columns
    NEWLINE
    DEC ecx
    JNZ .print_rows

    xor rax, rax
    ret