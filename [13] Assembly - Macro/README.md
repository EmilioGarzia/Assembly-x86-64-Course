# Assembly Course: Macro

- [Cos'è una macro](#cosè-una-macro)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Cos'è una macro?

Nei linguaggi ad alto livello come il `C` siamo abituati a scrivere codice sorgente seguento il paradigma del **clean code** per assicurare una certa leggibilità e modularità del codice. Una delle principali caratteristiche di un codice pulito è l'implementazione di funzioni che vadano a suddividere le parti salienti del codice principali, garantendo modularità e riuso di codice.

Anche in assembly possiamo riciclare segmenti di codice, queste porzioni di codice riutilizzabile prendono il nome di **macro** e non funzioni come invece si usa nei linguaggi convenzionali ad alto livello, piuttosto sarebbe più corretto considerare le procedure come corrispettivo delle funzioni, infatti le macro non ritornano alcun valore in output e sappiamo bene che le funzioni sono caratterizzate da argomrnti di input ed un valore di output.

# Sintassi per l'implementazione di una macro

L'implementazione di una macro è estremamente semplice ed utilizzano la seguente sintassi.

```nasm
%macro nome_macro numero_parametri
; body delle istruzioni da eseguire
%endmacro
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