LF db "",0xa              ; special char for new line 

; macro per la print di una stringa
%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, LF
    mov rdx, 1
    syscall
%endmacro

section .text
    global _start

_start:
    ; vector_byte[3]
    mov rcx,[vector_byte+3]    ; prendi elemento in posizione 3 del vettore
    mov [tmp], rcx             ; sposta l'elemento in una variabile temporanea
    add byte [tmp], '0'        ; converti il valore in ASCII
    print tmp, 1               ; stampa il valore in output

    ; vector_word[2]
    mov rcx, [vector_word+4]   ; una word è 2byte, quindi l'offset è a step di 2
    mov [tmp], rcx
    add byte [tmp], '0'
    print tmp, 1

    ; repeated_value[1]
    mov rcx, [repeated_value+2]   ; una word è 2byte, quindi l'offset è a step di 2
    mov [tmp], rcx
    add byte [tmp], '0'
    print tmp, 1

    ; Inizializzo i valori nel vettore dichiarato vuoto
    mov byte [empty_vector+0], 2
    mov byte [empty_vector+1], 4
    mov byte [empty_vector+2], 6
    mov byte [empty_vector+3], 8

    ; empty_vector[2]
    mov rcx, [empty_vector+2]   ; una word è 2byte, quindi l'offset è a step di 2
    mov [tmp], rcx
    add byte [tmp], '0'
    print tmp, 1

exit:                     ; system call exit
    mov rax, 60
    mov rdi, 0
    syscall

section .data
    vector_byte db 3,4,5,6,7     ; inizializza vettore di byte
    vector_word dw 1,2,3,4       ; inizializza vettore di word
    repeated_value times 5 db 2  ; vettore di 5 elementi inizilizzati a 2
    tmp db 0

section .bss
    empty_vector resb 4          ; dichiara un vettore di dimensione 4 non inizializzato