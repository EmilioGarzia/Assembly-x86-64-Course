section .text
    global _start

_start: 
    mov al, [x]
    add al, [y]
    daa

    or al, 30H
    mov [sum], al

exit:
    ; Termina il programma con la system call sys_exit
    mov rax, 60
    mov rdi, sum
    syscall

section .data
    x db '2'
    y db '10'

section .bss
    sum resb 2