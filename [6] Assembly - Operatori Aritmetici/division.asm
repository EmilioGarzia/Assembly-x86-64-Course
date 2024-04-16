SYS_EXIT equ 60     ; system call SYS_EXIT
SYS_WRITE equ 1     ; system call SYS_WRITE
STDOUT equ 1        ; standard output
LF db "", 0xa       ; carattere speciale di andata a capo

section .data
    dividend db 8
    divisor db 3

    ; Messaggi di output
    quotientMSG db "Quotient: "
    quoMsgLen equ $-quotientMSG
    remainderMSG db "Remainder: "
    remMsgLen equ $-remainderMSG
    
section .bss
    quotient resb 1     ; qui verrà contenuto il quoziente
    remainder resb 1    ; qui verrà contenuto il resto della divisione

section .text
    global _start

_start:

division:
    mov al, [dividend]      ; carico il dividendo nel registro al (obbligatorio)
    mov bl, [divisor]       ; carico il divisore nel registro bl (anche altri registri vanno bene)
    div bl                  ; applico l opcode per la divisione
    add ah, '0'             ; converto il resto contenuto in ah in codifica ASCII
    mov [remainder], ah     ; carico il resto in ASCII nella variabile [remainder]
    add al, '0'             ; converto il quoziente contenuto in al in codifica ASCII
    mov [quotient], al      ; carico il quoziente in ASCII nella variabile [quotient]

quotient_output:     ; OUTPUT del quoziente
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, quotientMSG
    mov rdx, quoMsgLen
    syscall
    
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, quotient
    mov rdx, 1
    syscall
    
    ; OUTPUT del carattere speciale LF
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, LF
    mov rdx, 1
    syscall

remainder_output:    ; OUTPUT del resto della divisione
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, remainderMSG
    mov rdx, remMsgLen
    syscall
    
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, remainder
    mov rdx, 1
    syscall

    ; OUTPUT del carattere speciale LF
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, LF
    mov rdx, 1
    syscall

exit:       ; SYS_EXIT
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall