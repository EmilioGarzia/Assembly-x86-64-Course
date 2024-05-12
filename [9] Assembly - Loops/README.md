# Assembly Course: Costrutto di iterazione

- [Assembly Course: Costrutti di selezione](#assembly-course-costrutti-di-selezione)
- [Iterazione con salti](#iterazione-con-salti)
- [Iterazione con opcode `loop`](#iterazione-con-opcode-loop)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Iterazione con salti

Con le attuali conoscenze siamo perfettamente in grado di implementare un ciclo all'interno del nostro programma assembly, infatti ci basterebbe dichiarare una variabile contatore ed una label che identifica il punto di inizio del loop, poi con un semplice salto condizionato, come per esempio `JNZ`, possiamo iterare il blocco di codice, di seguito uno snippet che mostra come potrebbe essere implementato un loop con un salto condizionato `JNZ`

```nasm
mov r8, 10      ; counter

loop: ; istruzioni del loop 
    dec r8      ; decrementa il valore di r8 di un'unità
    jnz loop    ; se r8 != 0, allora, salta di nuovo alla label "loop"
```

# Iterazione con opcode `loop`

I salti condizionati basterebbero per l'implementazione di un ciclo, comunque sia, nel set di istruzioni assembly ci viene messa a disposizione un istruzione specifica allo scopo chiamata `loop`, questo opcode ammette come unico operando la label in cui saltare che definisce il punto di inizio del loop, inoltre, viene utilizzato il registro `RCX` come variabile contatore, la sintassi dell'istruzione `loop` è definita come:

```nasm
mov rcx, 10          ; sposta il valore 10 nel registro contatore rcx

label1:              
    ; <istruzioni del loop>
    loop label1      ; decrementa il registro RCX e salta alla label "label1"
```

# Compilare ed eseguire un sorgente `*.asm`

Innanzitutto compiliamo il codice assembly con l'assemblatore `nasm` specificando il formato del file di output, nel nostro caso vogliamo un eseguibile *(che sotto Linux sono file di tipo `ELF`)* per architetture a `64bit`

```bash
nasm -f elf64 main.asm
```

Una volta generato il file oggetto `*.o` con l'assemblatore *nasm* possiamo linkare il tutto con il linker and loader, nel nostro caso abbiamo utilizzato come punto di ingresso la label `_start`, nel caso in cui avessimo utilizzato un altro nome per il punto di ingresso avremmo dovuto specificarlo con l'attributo `-e` del comando `ld`:

```bash
ld main.o -o program_name
```

Una volta ottenuto il file eseguibile, è possibile eseguirlo tranquillamente con:

```bash
./program_name
```
# References

[NASM](https://www.nasm.us/)

[System Call `x86-64`](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)

[System Call `x86-32`](https://www.tutorialspoint.com/assembly_programming/assembly_system_calls.htm)

# Author

Emilio Garzia, 2024