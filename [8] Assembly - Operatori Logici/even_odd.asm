; Pari e dispari
; @author Emilio Garzia, 2024
; @desc maggiori informazioni nel README.md

section .data
    value db 6                      ; valore da controllare
    evenMSG db " e' PARI",0xa       ; messaggio da stampare se pari
    evenMSGLen equ $-evenMSG        ; lunghezza stringa evenMSG
    oddMSG db " e' DISPARI", 0xa    ; messaggio da stampare se dispari
    oddMSGLen equ $-oddMSG          ; lunghezza stringa oddMSG

section .text
    global _start

_start:
    mov ax, [value]                 ; sposto il valore da controllare in ax
    and ax, 1                       ; value AND 1, se pari il campo PF di EFLAGS si setta a 1
    
    mov bx, [value]                 ; sposto il mio valore nel registro bx
    add bx, '0'                     ; converto il valore intero in ASCII
    mov [value], bx                 ; sposto il valore ASCII nell'indirizzo value

value_output:                       ; mando in output il valore da controllare
    mov rax, 1
    mov rdi, 1
    mov rsi, value
    mov rdx, 1
    syscall

    jz even                         ; se il campo PF di EFLAGS è settato a 1, salta direttamente alla label even, altrimenti continua proceduralmente

odd:                                ; stampa il messaggio di disparità
    mov rax, 1
    mov rdi, 1
    mov rsi, oddMSG
    mov rdx, oddMSGLen
    syscall

    jmp sys_exit                    ; salta incondizionatamente alla fine del programma, alla label sys_exit

even:                               ; stampa nel caso di parità
    mov rax, 1
    mov rdi, 1
    mov rsi, evenMSG
    mov rdx, evenMSGLen
    syscall

sys_exit:                           ; uscita del programma
    mov rax, 60
    xor rdi, rdi
    syscall