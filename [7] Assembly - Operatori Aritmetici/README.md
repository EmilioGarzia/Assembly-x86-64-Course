# Assembly Course: Operatori Aritmetici


- [Assembly Course: Operatori Aritmetici](#assembly-course-operatori-aritmetici)
- [Operatori aritmetici in Assembly](#operatori-aritmetici-in-assembly)
- [Moltiplicazione `MUL/IMUL`](#moltiplicazione-mulimul)
- [Divisione `DIV/IDIV`](#divisione-dividiv)
- [Altre informazioni utili](#altre-informazioni-utili)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Operatori aritmetici in Assembly

In questa lezione vedremo gli operatori aritmetici di base del linguaggio assembly, una cosa importante da sapere è che quando utilizziamo gli operatori aritmetici su delle variabili da noi definiti è obbligatorio specificare il size di queste variabili quando invochiamo l'operatore, per esempio se la nostra variabile è definita come `db`, allora dovremmo specificare `byte [variabile]` nell'operazione.

| Operatore | Descrizione | Esempio di utilizzo |
|:-:|:-:|:-:|
| `inc` | incrementa il valore di `1` | `inc byte [variable]`, `inc <register>` |
| `dec` | decrementa il valore di `1` | `dec byte [variable]`, `dec <register>` |
| `add` | Aggiunge il valore specificato nel secondo operando nel valore del primo operando | `add <reg1>, <reg2>`, `add <size> [variable], costant_value` |
| `sub` | Sottrae il valore specificato nel secondo operando nel valore del primo operando | `sub <reg1>, <reg2>`, `sub <size> [variable], costant_value` |

# Moltiplicazione `MUL/IMUL`

# Divisione `DIV/IDIV`

# Altre informazioni utili

<parlare del fatto che al momento non si possono stampare doppie cifre, della conversione in ASCII e viceversa>

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