SYS_EXIT equ 60
SYS_WRITE equ 1
STDIN equ 1
LF db "", 0xa

section .data
    val1 db 6
    val2 db 2

section .bss
    res resb 1

section .text
    global _start

_start:

multiplication:
    mov al, [val1]    ; sposto il molltiplicando nel registro AL
    mov bl, [val2]    ; sposto il moltiplicatore nel registro BL
    mul bl            ; eseguo la moltiplicazione sul moltiplicatore
    add al, '0'       ; il risultato del prodotto si trova in AL, quindi per stamparlo lo rendo ASCII
    mov [res], al     ; sposto il risultato in ASCII nella variabile [res]

output:     ; SYS_WRITE
    mov rax, SYS_WRITE
    mov rdi, STDIN
    mov rsi, res
    mov rdx, 1
    syscall
    
    mov rsi, LF       ; stampa il carattere speciale "Line Feed" (andata a capo)
    syscall

exit:       ; SYS_EXIT
    mov rax, SYS_EXIT
    mov rdi, [res]
    syscall