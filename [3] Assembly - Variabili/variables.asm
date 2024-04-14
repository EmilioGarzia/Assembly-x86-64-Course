section .data
    exit_value equ 0x0A   ; dichiaro una variabile con codifica esadecimale

section .text
    global _start         ; definisco la label di inizio del programma per il linker

_start:
    mov al, 60            ; specifico la system call per la exit (sys_exit)
    mov dil, exit_value   ; specifico il valore che voglio ritornare all'uscita del programma
    syscall               ; invoco la system call che eseguirà le istruzioni di cui sopra