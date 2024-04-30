; 9 to 1 output with a loop opcode
; @author Emilio Garzia, 2024

LF db "",0xa                ; carattere speciale new line

section .bss
    val resb 1

section .text
    global _start

_start:
    mov rcx, 9              ; sposto il valore 9 nel registro rcx (registro contatore)

loop_start:
    mov [val], rcx          ; copio il valore in una variabile
    add byte [val], '0'     ; converto il valore in stringa
    
    push rcx                ; porto il registro sullo stack, cosi da non perdere il valore del counter

    ; output del valore del counter
    mov rax, 1
    mov rdi, 1
    mov rsi, val
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, LF
    mov rdx, 1
    syscall

    sub byte [val], '0'   ; riporto il valore della variabile ad un tipo numerico

    pop rcx               ; prelevo il registro rcx dallo stack e lo carico in memoria

    loop loop_start       ; decremento il registro rcx e salto alla label, se rcx è maggiore di 0

exit:                     ; system call exit
    mov rax, 60
    mov rdi, 0
    syscall