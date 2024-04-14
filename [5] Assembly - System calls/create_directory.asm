section .bss
    dir_name RESB 11  ; Aggiungi un byte aggiuntivo per il carattere di terminazione NULL

section .text
    global _start

_start:
    ; Prende in Input il nome della cartella con la system call sys_read
    mov rax, 0
    mov rdi, 0
    mov rsi, dir_name
    mov rdx, 10
    syscall

    ; Chiude lo stream in input con la system call sys_close
    mov rax, 3
    mov rdi, 0
    syscall

    ; Crea una directory con la system call sys_mkdir
    mov rax, 83
    mov rdi, dir_name
    mov rsi, 0777
    syscall

    ; Termina il programma con la system call sys_exit
    mov rax, 60
    mov rdi, 0
    syscall
