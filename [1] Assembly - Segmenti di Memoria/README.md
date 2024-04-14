# Assembly Course: Segmenti di memoria

- [Assembly Course: Segmenti di memoria](#assembly-course-segmenti-di-memoria)
- [Cosa sono i segmenti di memoria?](#cosa-sono-i-segmenti-di-memoria)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Cosa sono i segmenti di memoria?

Nel capitolo precedente abbiamo introdotto il concetto di sezione con il comando `.section`, queste sezioni detereminano segmenti di memoria predisposti a specifici compiti e come abbiamo visto di default sono implementati vari segmenti di memoria, tra cui:

* `.text`
* `.bss`
* `.data`

Infatti, se nel nostro codice di `Hello World` visto nel capitolo introduttivo sostituiamo la keyword `section` con la keyword `segment` l'output del nostro programma non cambia.

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

# Author

Emilio Garzia, 2024