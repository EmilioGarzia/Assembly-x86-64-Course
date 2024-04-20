# Assembly Course: Costrutti di selezione

- [Assembly Course: Costrutti di selezione](#assembly-course-costrutti-di-selezione)
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