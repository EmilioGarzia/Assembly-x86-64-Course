# Assembly Course: Operatori Logici

- [Introduzione alle operazioni logiche in assembly](#introduzione-alle-operazioni-logiche-in-assembly)
- [Operatori logici in assembly](#operatori-logici-in-assembly)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Introduzione alle operazioni logiche in assembly

Le operazioni logichè coinvolgono due operandi di input, in assembly il primo operando va contenuto in un area di memoria *(label)* o in un registro, mentre il secondo operando può essere contenuto o in un area di memoria/registro o può essere un valore immediato.

Questi operatori eseguono dei confronti bit-a-bit *(bitwise)* sui due operandi coinvolti nell'operazione, una volta eseguita un operazione logica verranno modificati i campi `CF`, `OF`, `PF`, `SF` e `ZF` del registro `EFLAGS`.

# Operatori logici in assembly

| Porta logica | Descrizione | Esempio di utilizzo |
|:-:|:-:|:-:|
| `AND` | Esegue un **AND** bitwise tra due operandi | `and operand1, operand2` |
| `OR` | Esegue un **OR** bitwise tra due operandi | `or operand1, operand2` |
| `XOR` | Esegue uno **XOR** bitwise tra due operandi | `xor operand1, operand2` |
| `TEST` | Esegue un **AND** bitwise tra due operandi, ma senza modificare il valore del primo operando | `test operand1, operand2` |
| `NOT` | Esegue un **NOT** bitwise su un operando | `not operand1` |

# Dettagli sul codice `even_odd.asm`

Di seguito alcune informazioni aggiuntive sul funzionamento del codice che controlla la parità di un valore intero:

* Molto banalmente nel programma viene eseguita un operazione di `AND` bit-a-bit con il nostro valore ed il valore immediato `1`, questo perchè se il nostro valore iniziale è pari, allora, il risultato dell'AND con il valore uno sarà pari, altrimenti, sarà dispari
    * Quando un operazione ritorna come valore un valore pari, allora, il campo `PF` *(parity flag)* del registro `EFLAGS` viene settato a `1`, altrimenti rimane a `0`
* A questo punto abbiamo utilizzato un concetto che vedremo nella prossima lezione, ovvero il concetto di salti condizionati ed incondizionati, al momento ci basti sapere che con l'istruzione `jz` si controlla il campo `PF` e se questo è settato a `1`, allora salta alla parte di codice la cui label è pari a `even`, altrimenti continua normalmente a scorrere le istruzioni successive
    * Nel codice è stato implementato anche un salto incondizionato `JMP`, questo perchè se siamo nello scenario dispari, alla fine dobbiamo saltare incondizionatamente alla fine del programma, se non usassimo questo salto, subito dopo la porzione di codice che tratta la disparità verrebbe eseguita anche la pparte di codice delle parità
* E' possibile tenere d'occhio i bit del registro `EFLAGS` tramite il debugger `GDB` che vedremo verso le ultime lezioni

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