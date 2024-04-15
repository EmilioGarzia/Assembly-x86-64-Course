; x AND y = z
; 1111 AND 0101 = 0101 = 5
; @author Emilio Garzia, 2024

section .data
    x db 0b1111     ; X = 1111
    y db 0b0101     ; Y = 0101
    LF db '',0xa    ; carattere speciale LF (andata a capo)

section .bss
    z resb 1

section .text
    global _start

_start:

and_operation:      ; applico l'operatore AND
    mov ax, [x]     ; carico in AX il primo operando
    and ax, [y]     ; calcolo l'AND bitwise con l'operando y
    add ax, '0'     ; aggiungo il carattere speciale per la conversione in ASCII
    mov [z], ax     ; sposto il valore in ASCII nella label z

output:             ; mando in output il valore ottenuto
    mov rax, 1
    mov rdi, 1
    mov rsi, z
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, LF     ; stampo il carattere speciale LF (andata a capo)
    mov rdx, 1
    syscall

sys_exit:
    mov rax, 60
    mov rdi, 0
    syscall