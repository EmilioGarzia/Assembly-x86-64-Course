# Assembly Course: Operatori Aritmetici


- [Assembly Course: Operatori Aritmetici](#assembly-course-operatori-aritmetici)
- [Operatori aritmetici in Assembly](#operatori-aritmetici-in-assembly)
- [Moltiplicazione `MUL/IMUL`](#moltiplicazione-mulimul)
- [Divisione `DIV/IDIV`](#divisione-dividiv)
- [Osservazioni sui codici implementati](#osservazioni-sui-codici-implementati)
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

L'operazione di moltiplicazione è implementabile attraverso due differenti `opcode`:

- `MUL` &rarr; Esegue il prodotto che coinvolge valori senza segno
- `IMUL` &rarr; Esegue il prodotto che coinvolge valori con segno

Per quanto riguarda il moltiplicando in entrambi i casi viene utilizzato un registro *accumulatore*, in base alle dimensioni del *moltiplicatore* e del *moltiplicando* sceglieremo la porzione di registro accumulatore da utilizzare, per esempio se i valori sono di size `byte`, allora il moltiplicando va inserito nel registro `AL`, se il size è `word`, allora il moltiplicando va nel registro `AX`, `EAX` per il `32bit` ed infine `RAX` per i valori di dimensione `64bit`.

Come abbiamo già detto per eseguire il prodotto tra due operandi è necessario utilizzare il registro `rax` o sue sotto porzioni, in cui verrà memorizzato il moltiplicando, mentre per quanto riguarda il molitplicatore, può essere contenuto altrove e sarà proprio sul moltiplicatore che verrà eseguito il comando `MUL` o `IMUL`, il risultato del prodotto sarà poi contenuto in `rax`.

![registri per la moltiplicazione](images/mul_register.svg)

> ⚠: Il risultato della moltiplicazione viene contenuto in due differenti registri, nel primo vi sono i bit più significativi del prodotto, mentre nel secondo, i bit meno significativi.

# Divisione `DIV/IDIV`

Anche per la divisione i meccanismi sono molto simili alla moltiplicazione, anche in questo caso abbiamo due divrsi comandi per il calcolo del quoziente e del resto:

- `DIV` &rarr; Per la divisione di dati senza segno
- `IDIV` &rarr; Per la divisione di dati con segno

Anche in questo caso in base alle dimensioni delle informazioni possiamo utilizzare interi registri e sotto registri, ricordando che il **dividendo** va inserito nel registro accumulatore `rax`, nel nostro esempio siccome lavoriamo con informazini grandi $8bit$ utilizziamo la sotto porzione `al` di `rax`.

![registri divisione](images/division.svg)

# Osservazioni sui codici implementati

* Negli esercizi in questa lezione abbiamo visto come fare il cast di un valore intero in una informazione `ASCII` aggiungendo (con il comando `add`) all'informazione il carattere speciale `'0'`
  * E' possibile anche eseguire il cast da `ASCII` ad `INTEGER` sottraendo (con l'operatore `SUB`) dall'informazione il carattere speciale `'0'`
* In questo punto del corso non siamo ancora in grado di stampare in output valori numerici con più di una cifra, perchè la loro gestione è un pò più complessa, per questo motivo negli esempi implementati si sono scelti valori affinchè l'output sia sempre un vavlore numerico single-digit

> Esempio di codice che mostra come eseguire il cast di un `ASCII` in `int`

```asm
mov rax, '4'  ; carica il carattere '4' in $rax
sub rax, '0'  ; converte il carattere ASCII in un valore numerico integer
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