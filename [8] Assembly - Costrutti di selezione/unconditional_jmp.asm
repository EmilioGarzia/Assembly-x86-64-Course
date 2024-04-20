; Qusto codice eseguirà i blocchi di codice in quest'ordine:
; _start -> label2 -> label1 -> label3 -> exit  

section .data
    L1msg db "Label 1",0xa
    L1len equ $-L1ms1g
    L2msg db "Label 2",0xa
    L2len equ $-L2msg
    L3msg db "Label 3",0xa
    L3len equ $-L3msg

section .text
    global _start

_start:
    jmp label2

label1:
    mov rax, 1
    mov rdi, 1
    mov rsi, L1msg
    mov rdx, L1len
    syscall

    jmp label3

label2:
    mov rax, 1
    mov rdi, 1
    mov rsi, L2msg
    mov rdx, L2len
    syscall

    jmp label1

label3:
    mov rax, 1
    mov rdi, 1
    mov rsi, L3msg
    mov rdx, L3len
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
    syscall