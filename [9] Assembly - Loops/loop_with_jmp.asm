; Print number to from 9 to 0, with a jump loop implementation
; @author Emilio Garzia, 2024

section .data
    i db 10                 ; counter value
    n  db 10                ; n value
    LF db "",0xa

section .text
    global _start

_start:

loop:
    dec byte [n]           ; decrease n value
    add byte [n], '0'      ; convert n to ASCII code

    mov rax, 1
    mov rdi, 1
    mov rsi, n
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, LF
    mov rdx, 1
    syscall

    sub byte [n], '0'       ; convert n to number
    
    jnz loop                ; if not zero, jump to loop label

exit:
    mov rax, 60
    mov rdi, 0
    syscall