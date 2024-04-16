section .data
    array db 1,2,3,4,5

section .text
    global _start

_start:
    mov rax, 60
    mov rdi, array[1]  ; return the 2nd element in array
    syscall