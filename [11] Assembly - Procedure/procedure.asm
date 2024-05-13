; Assembly procedures

section .data
    x db 5
    y db 3
    LF db '', 0xa

section .bss
    res resb 1

section .text
    global _start

_start:
    call sum       ; chiamata alla procedura

output:
    mov rax, 1
    mov rdi, 1
    mov rsi, res
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, LF
    mov rdx, 1
    syscall 

    jmp exit

; procedura per la somma
sum:
    mov eax, [x]
    add eax, [y]
    add eax, '0'
    mov [res], eax
    ret

exit:
    mov rax, 60
    mov rdi, 0
    syscall