# Assembly Course: Costrutti di selezione

- [Assembly Course: Costrutti di selezione](#assembly-course-costrutti-di-selezione)
- [Salti incondizionati e salti condizionati](#salti-incondizionati-e-salti-condizionati)
- [L'istruzione "compare" `CMP`](#listruzione-compare-cmp)
- [Salti incondizionati `JMP`](#salti-incondizionati-jmp)
- [Salti condizionati](#salti-condizionati)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Salti incondizionati e salti condizionati

In assembly i costrutti di selezione hanno una struttura differente rispetto a come siamo abituati ai linguaggio più ad alto livello come il `C`, quando implementiamo un costrutto di selezione nei nostri sorgenti quello che stiamo facendo è "saltare" da un punto del codice ad un altro e questo salto può avvenire secondo due possibili scenari:

* **Salti incondizionati** &rarr; Sono salti che vengono eseguiti a prescindere, senza alcun tipo di condizione, è possibile saltare da una parte del codice all'altra con l'operatore `JMP` che come unico operando ammette la label del blocco di codice a cui si vuole saltare
* **Salti condizionati** &rarr; Questo genere di salti invece vengono eseguito successivamente ad un controllo eseguito con l'operatore *compare* `CMP`

# L'istruzione "compare" `CMP`

L'istruzione "compare" esegue il confronto tra due valori numerici, la struttura di base del comando `CMP` è:

```nasm
CMP destination, source
```

* `destination` &rarr; può essere un valore in memoria o i un registro
* `source` &rarr; può essere un valore immediato *(costante)*, in memoria o in un registro

# Salti incondizionati `JMP`

Il concetto di salto incondizionato è molto semplice da comprendere, come vedremo anche negli esempi, utilizziamo l'istruzione `JMP` per saltare da una parte all'altra del codice in maniera imprescindibile e quindi senza necessariamente adempiere ad una specifica condizione.

```nasm
; some instruction
jmp label2
label1:
; the code block into label1 will be skipped
label2:
; instruction into label2
```

# Salti condizionati

A differenza dell'opcode `JMP` visto precedentemente, quelli che tratteremo ora sono tutti salti che vengono effettuati solamente se nel programma avvengono specifiche condizioni, volendo fare riferimenti al linguaggio `C`, i salti condizionati sono l'equivalente del costrutto `IF-THEN-ELSE` o dello `SWITCH CASE`, ma a basso livello.

Quando eseguiamo un operazione od un confronto nel nostro programma assembly, l'esito di quella operazione va ad alterare uno o più specifici campi del registro `EFLAGS`, per esempio, se il risultato di una qualsiasi operazione aritmetica è un numero pari, allora, il campo `PF` del registro `EFLAGS` è settato a `1`, altrimenti è settato a `0`. Dunque, i flags sono fondamentali per determinare i salti condizionati in un programma assembly.

Di seguito un elenco di tutti gli opcode che abbiamo a disposizione per l'implementazione di un salto condizionato:

| OPCODE | Descrizione | Flag coinvolti | Tipi di numeri su cui lavora |
|:-:|:-:|:-:|:-:|
| `JE`/`JZ` | Salta se uguale / Salta se uguale a `0` | `ZF` | signed/unsigned |
| `JNE`/`JNZ` | Salta se diverso / Salta se diverso da `0`  | `ZF` | signed/unsigned |
| `JG`/`JNLE` | Salta se maggiore / Salta se non è minore o uguale  | `ZF`, `OF`, `SF` | signed |
| `JGE`/`JNL` | Salta se maggiore o uguale / Salta se non è minore | `OF`, `SF` | signed |
| `JL`/`JNGE` | Salta se minore / Salta se non maggiore o uguale | `OF`, `SF` | signed |
| `JLE`/`JNG` | Salta se minore o uguale / Salta se non maggiore | `OF`, `SF`, `ZF` | signed |
| `JA`/`JNBE` | Salta se maggiore / Non saltare se minore o uguale | `CF`, `ZF` | unsigned |
| `JAE`/`JNB` | Salta se maggiore o uguale / Salta se non è minore | `CF` | unsigned |
| `JB`/`JNAE` | Salta se minore / Salta se non è maggiore o uguale | `CF` | unsigned |
| `JBE`/`JNA` | Salta se minore o uguale / Salta se non è maggiore | `CF`, `AF` | unsigned |

Oltre ai salti dovuti a condizioni di confronto tra numeri con segno e senza segno, vi è anche un'altra classe di salti che avvengono in determinati condizioni speciali, di seguito un elenco di questa tipologia di salti:

| OPCODE | Descrizione | Flag coinvolti |
|:-:|:-:|:-:|
| `JXCZ` | Salta se il flag `CX` è `0` |  |
| `JC` | Salta se l'ultima operazione aritmetica ha generato un riporto | `CF` |
| `JNC` | Salta se l'ultima operazione aritmetica non ha generato un riporto | `CF` |
| `JO` | Salta se l'ultima operazione ha generato un overflow di memoria | `OF` |
| `JNO` | Salta se l'ultima operazione non ha generato un overflow di memoria | `OF` |
| `JP`/`JPE` | Salta se il risultato dell'operazione è un numero pari / Salta se il risultato dell'operazione è un numero dispari | `PF` |
| `JNP`/`JPO` | Salta se il risultato dell'operazione non è un numero pari / Salta se il risultato dell'operazione non è un numero dispari | `PF` |
| `JS` | Salta se il risultato dell'operazione è un numero negativo | `SF` |
| `JNS` | Salta se il risultato dell'operazione è un numero positivo | `SF` |

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