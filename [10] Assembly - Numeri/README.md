# Assembly Course: Numeri

- [Codifica dei numeri in assembly](#compilare-ed-eseguire-un-sorgente-asm)
- [Numeri in codifica `ASCII`](#numeri-in-codifica-ascii)
    - [Operazioni aritmetiche su numeri `ASCII`](#operazioni-aritmetiche-su-numeri-ascii) 
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Codifica dei numeri in assembly

I numeri in assembly sono rappresentati tramite codifica **binaria**, dunque, le operazioni aritmetiche lavorano su valori binari, tuttavia, quando andiamo a prendere un valore numerico in input dalla tastiera, oppure quando vogliamo stamparlo sulla console di sistema è necessario convertire questo valore da codifica binaria a codifica **ASCII**.

Quindi qualora volessimo prendere in input due numeri da tastiera per sommarli tra di loro, dovremmo implementare un codice che:

1. Prenda in input i due numeri dallo standard input
1. I numeri presi in input sono in codifica **ASCII**, quindi li convertiamo in **binario**
1. Una volta ottenuti i valori in binario possiamo lavorarci su applicando tutte le operazioni aritmetiche desiderate
1. A questo punto possiamo riconvertire in **ASCII** i valori binari, così da poterli mostrare sullo standard output

Ci si rende subito conto che tale approccio è estremamente prolisso in termini di sintassi e soprattutto aumenta notevolmente [l'overhead](https://it.wikipedia.org/wiki/Overhead), per nostra fortuna il linguaggio assembly ci mette a disposizione una serie di `opcode` che ci consentono di eseguire queste operazioni aritmetiche in maniera molto più efficiente, dandoci la possibilità di poter lavorare direttamente su due tipologie di codifiche:

* Codifica **ASCII**
* Codifica **BCD** *(binario)*

# Numeri in codifica ASCII

Nella rappresentazione *ASCII* ogni cifra del notro numero è in realtà un carattere, e numeri composti da più cifre non sono altro che una stringa di caratteri.

La codifica ASCII definisce un valore intero a `8bit` per ogni carattere contenuto nello standard ASCII, lo stesso vale anche per i numeri decimali, che vengono sì mostrati a noi come un carattere, ma la macchina lo legge come il suo corrispettivo decimale ASCII, di seguito una tabella che mostra la codifica ASCII dei numeri decimali:

| Decimale | ASCII code *(in esadecimale)*|
|:-:|:-:|
| `0` | `30` |
| `1` | `31` |
| `2` | `32` |
| `3` | `33` |
| `4` | `34` |
| `5` | `35` |
| `6` | `36` |
| `7` | `37` |
| `8` | `38` |
| `9` | `39` |

Quindi se si vuole rappresentare il numero `1234` in ASCII scriveremo una stringa del tipo:

| 1 | 2 | 3 | 4 |
|:-:|:-:|:-:|:-:|
| `31H` | `32H` | `33H` | `34H` |

## Operazioni aritmetiche su numeri ASCII



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