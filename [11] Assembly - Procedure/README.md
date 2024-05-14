# Assembly Course: Procedure

- [Cosa sono le procedure?](#cosa-sono-le-procedure)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Cosa sono le procedure?

Conoscere le procedure è fondamentale per snellire i nostri codici sorgenti scritti in assembly, possiamo considerare le procedure come delle sub routine, volendo utilizzare un termine più ad alto livello, possiamo vederle come delle funzioni, ma in questo caso le sub routine non ritornano alcun risultato, poichè la parola chiava `ret` ci permette semplicemente di eseguire un jump all'istruzione successiva alla chiamata della sub routine.

L'implementazione di una procedura in assembly è estremamente semplice, e sono due fondamentalmente le istruzioni che ci serve conoscere sono `CALL` per eseguire una chiamata alla procedura, e `ret` per ritornare dalla procedura e continuare la normale esecuzione del programma.

> Struttura di una procedura in assembly

```nasm
; istruzioni assembly
call procedure_name
procedure_name:
    ; body della procedura
    ret
; altro codice asssembly
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