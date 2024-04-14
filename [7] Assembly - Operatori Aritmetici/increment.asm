section .data 
    SYS_EXIT  equ 60
    SYS_WRITE equ 1
    STDOUT    equ 1

    counter db 0
section	.text
    global _start

_start:      
    ; incremento il valore di counter 3 volte
    inc byte [counter]
    inc byte [counter]
    inc byte [counter]

    ; conversione del valore in ASCII
    add eax, [counter]      ; sposto il valore di counter in eax
    add eax, '0'            ; convero il valore in eax in ASCII
    mov [counter], eax      ; ricopio il valore convertito in counter 

    ; eseguo la print sulla console
write:
    mov rax, SYS_WRITE         
    mov rdi, STDOUT         
    mov rsi, counter
    mov rdx, 2
    syscall              

    ; termino il programma
exit:    
    mov rax, SYS_EXIT   
    xor rdi, rdi 
    syscall