; Questo è un commento e questo è un programma di Hello World in assembly

; sezione in cui definire l'inizializzazione delle variabili
section .data
    msg db 'Hello World!', 0xa     ; messaggio da stampare
    len equ $-msg                  ; dimensione della stringa da stampare

; sezione che definisce il codice che dovrà essere eseguito
section .text
    global _start  ; definizione di una label globale, utile al linker

_start:
    mov edx, len       ; dimensione del messaggio
    mov ecx, msg       ; messaggio da scrivere
    mov ebx, 1         ; file descriptor (stdout)
    mov eax, 4         ; system call per la scrittura su console (sys_write)
    int 0x80           ; chiamata al kernel

    mov eax, 1         ; system call per la chiusura del programma (sys_exit)
    int 0x80           ; chiamata al kernel