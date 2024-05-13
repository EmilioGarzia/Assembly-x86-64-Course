; implementazione di una macro per l'output sulla console
; @author Emilio Garzia, 2024 

; definizione della macro
%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

section .data
    msg db "Ciao a tutti", 0xa
    msgLen equ $-msg

section .text
    global _start

_start:
    print msg, msgLen

exit:
    mov rax, 60
    mov rdi, 0
    syscall