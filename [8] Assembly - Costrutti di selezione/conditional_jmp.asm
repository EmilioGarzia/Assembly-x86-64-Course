section .data
    gtMSG db " e' maggiore di "
    gtMsgLen equ $-gtMSG
    ltMSG db " e' minore di "
    ltMsgLen equ $-ltMSG
    eqMSG db " e' uguale a "
    eqMsgLen equ $-eqMSG
    LF db "",0xa                        ; special char -> new line
    x db 1                              ; input value 1
    y db 6                              ; input value 2

section .text
    global _start

_start:
    mov al, [x]                         ; move x into al register
    mov bl, [y]                         ; move y into bl register
    
    cmp al, bl                          ; compare x and y values

    je equal                            ; if x==y then jump to "equal" label
    jl less_than                        ; if x<y then jump to "less_than" label
    jg great_than                       ; if x>y then jump to "great_than" label

great_than:
    add byte [x], '0'                   ; convert x value into ASCII code
    add byte [y], '0'                   ; convert y value into ASCII code

    ; print x
    mov rax, 1                         
    mov rdi, 1
    mov rsi, x
    mov rdx, 1
    syscall

    ; print message
    mov rax, 1
    mov rdi, 1
    mov rsi, gtMSG
    mov rdx, gtMsgLen
    syscall

    ; print y
    mov rax, 1
    mov rdi, 1
    mov rsi, y
    mov rdx, 1
    syscall

    ; print new line
    mov rax, 1
    mov rdi, 1
    mov rsi, LF
    mov rdx, 1
    syscall

    jmp exit                            ; jump to system exit label

less_than:
    add byte [x], '0'
    add byte [y], '0'

    mov rax, 1
    mov rdi, 1
    mov rsi, x
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, ltMSG
    mov rdx, ltMsgLen
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, y
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, LF
    mov rdx, 1
    syscall

    jmp exit

equal:
    add byte [x], '0'
    add byte [y], '0'
    
    mov rax, 1
    mov rdi, 1
    mov rsi, x
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, eqMSG
    mov rdx, eqMsgLen
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, y
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, LF
    mov rdx, 1
    syscall

exit:
    mov rax, 60
    mov rdi, 0
    syscall