; nasm/x86-64 code

section .data
scale_255: dd 255.0

section .text
bits 64
default rel
global imgCvtGrayFloatToInt

imgCvtGrayFloatToInt:
    sub rsp, 32

    movss xmm1, dword [rel scale_255]
    mulss xmm0, xmm1              ; xmm0 = float * 255

    cvtss2si eax, xmm0            ; Convert to int (now properly floored)

    mov [rdx], eax                ; Store result

    add rsp, 32
    ret

