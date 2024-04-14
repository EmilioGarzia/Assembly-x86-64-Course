section .data
    my_vector db 1, 2, 3, 4, 5

section .text
    global _start

_start:
    lea bx, [my_vector+1]
    mov eax, [bx]