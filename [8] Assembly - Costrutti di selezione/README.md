# Assembly Course: Costrutto di iterazione

- [Assembly Course: Costrutti di selezione](#assembly-course-costrutti-di-selezione)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)


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