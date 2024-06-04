# Assembly-x86-64-Course

In questa repository sono contenuti una serie di sorgenti scritti in linguaggio **assembly** per l'assemblatore *open source* `NASM`, ogni argomento trattato è corredato di relativo **markdown** denominato `README.md`.

ℹ️: Per comprendere al meglio tutti i concetti è fondamentale leggere prima i README file e poi analizzare il codice sorgente della relativa lezione.

# Conoscenze richieste

* [Basi sul linguaggio C](https://www.w3schools.com/c/index.php)

* [ASCII Code](https://www.ieee.li/computer/ascii.htm)

* [Codifica Binaria, Decimale ed Esadecimale](https://it.wikipedia.org/wiki/Codice_binario)

* [Concetti elementari sulla memoria principale](https://it.wikipedia.org/wiki/Memoria_(informatica))

* [Debugger GDB *(altamente consigliato)*](https://en.wikipedia.org/wiki/GNU_Debugger)

# Dipendenze

* [Assemblatore NASM](https://www.nasm.us/)

* [Linker GNU `LD`](https://it.wikipedia.org/wiki/GNU_linker)

* [Debugger GDB](https://en.wikipedia.org/wiki/GNU_Debugger)

* [Compilatore GCC *(facoltativo)*](https://gcc.gnu.org/)

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

# Autore

*Emilio Garzia, 2024*
