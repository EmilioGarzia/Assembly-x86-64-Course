; Corso Assembly: Utilizzo delle system call
; @desc programma che prende in input un valore e lo stampa a schermo
; @author Emilio Garzia, 2024

section .bss
    value resw 1

section .data
    inputMsg db "Inserisci un numero: "
    len equ $-inputMsg
    outputMsg db "Hai inserito il valore: "
    lenOut equ $-outputMsg

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, inputMsg
    mov rdx, len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, value
    mov rdx, 5
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, outputMsg
    mov rdx, 2
    add rdx, value
    add rdx, 0xa
    syscall

    mov rax, 60
    mov rdi, 0
    syscall