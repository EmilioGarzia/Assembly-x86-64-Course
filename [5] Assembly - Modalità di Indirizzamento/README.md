# Assembly Course: Modalità di indirizzamento

- [Introduzione](#introduzione)
- [Indirizzamento sui registri](#indirizzamento-sui-registri)
- [Indirizzamento Immediato](#indirizzamento-immediato)
- [Indirizzamento diretto della memoria](#indirizzamento-diretto-della-memoria)
- [Indirizzamento con offset diretto](#indirizzamento-con-offset-diretto)
- [Indirizzamento indiretto](#indirizzamento-indiretto)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Introduzione

In questa lezione andiamo ad approfondire quelli che sono i meccanismi che regolano la sintassi del linguaggio assembly, è ormai chiaro che essendo un linguaggio a basso livello, l'assembly non ci fornisce alcun tipo di aiuto sulla gestione della memoria, pertanto a seguire vedremo alcune tecniche per l'indirizzamento. Questo ci consentirà per esempio di accedere agli elementi di un vettore.

Ribadiamo la struttura di base di uno statement in assembly:

```nasm
<opcode> <operand1>, <operand2>, ..., <operandN>
```

Nel caso degli `opcode` per l'indirizzamento si hanno generalmente solamente due operandi, dove il primo specifica la destinazione in cui andranno memorizzate le informazioni, mentre, il secondo conterrà la soergente dei dati, ottenendo una struttura del tipo:

```nasm
; <opcode> <destination>, <source>
mov EAX, 10   ; sposta il valore 10 nel registro EAX
```

L'esempio che implementa l'opcode `mov` mostrato sopra è un esempio di **indirizzamento immediato** ed è solamente una delle molteplici possibilità che abbiamo in assembly per l'indirizzamento.

In questo capitolo tratteremo le seguenti tipologie di indirizzamento:

* *Indirizzamento sui Registri*
* *Indirizzamento Immediato*
* *Indirizzamento della memoria*
* *Indirizzamento diretto*

# Indirizzamento sui registri

In questo caso molto semplicemente si specifica la possibilità di utilizzare registri come `operand` di un `opcode` per l'indirizzamento.

```nasm
; Indirizzamento sui registri
mov EAX, VARIABLE     ; registro come primo operando
mov VARIABLE, EAX     ; registro come secondo operando
mov EAX, EBX          ; entrambi gli operandi sono registri
```

# Indirizzamento immediato

Effettuiamo un indirizzamento immediato quando il secondo operando *(sorgente)* è un valore costante od una espressione, mentre il primo operando *(destinazione)* è solitamente una variabile od un registro.

```nasm
BYTE_VALUE  DB  150    ; A byte value is defined
WORD_VALUE  DW  300    ; A word value is defined
ADD  BYTE_VALUE, 65    ; An immediate operand 65 is added
MOV  AX, 45H           ; Immediate constant 45H is transferred to AX
```

# Indirizzamento diretto della memoria

Con il termine indirizzamento diretto s'intende quella prassi che prevede di accedere direttamente alla memoria che contiene le informazioni a cui vogliamo accedere, dunque quello che facciamo è riferirci all'**indirizzo effettivo** che contiene lo specifico valore che stiamo cercando.

Prima di vedere qualche esempio pratico dobbiamo necessariamente  introdurre un nuovo carattere speciale del linguaggio assembly, ovvero le parentesi quadre `[]`, quando utilizziamo le quadre, intendiamo specificare il valore contenuto in quello specifico indirizzo di memoria.

```nasm
mov eax, [0x1000]   ; sposta in EAX il valore contenuto all'indirizzo di memoria 0x1000
```

Nello specifico quando utilizziamo le quadre stiamo eseguendo operazioni che coinvolgono l'accesso alla memoria, invece se non le usassimo si prenderebbe solamente in considerazione il valore immediato contenuto in quell'area di memoria.

# Indirizzamento con offset diretto

Questa tecnica utilizza gli operatori artimetici per spostarsi tra le locazioni di memoria, risulta molto utile per accedere agli elementi di un array, in quanto a quel punto ci basterà conoscere l'indirizzo di origine di un vettore per poi spostarci secondo uno specifico offset per accedere agli elementi desiderati, di seguito alcuni esempi pratici:

```nasm
byte_vector DB 1, 2, 3, 4, 5    ; array di byte
word_vector DW 12, 65, 60, 1    ; array di word (2byte per indice)
```

Una volta definiti i nostri vettori, possiamo accedere agli elementi di quest'ultimi in vari modi:

```nasm
mov cl, byte_vector[2]     ; ottieni il terzo elemento del vettore
mov cl, byte_vector+2      ; ottieni il terzo elemento del vettore
mov cx, word_vector[3]     ; ottieni il quarto elemento del vettore
mov cx, word_vector+3     ; ottieni il quarto elemento del vettore
```

# Indirizzamento indiretto

L'indirizzamento indiretto è una tipologia di indirizzamento che ha senso quando si ha che fare con i vettori, nello specifico vengono utilizzait i registri `ebx` o `ebp` ed i registri indice `di` ed `si`, codificati tra parentesi quadre per operare tramite riferimento della memoria, in sostanza con questa tecnica quello che andiamo a fare è simulare sostanzialmente la meccanica dei puntatori tanto utilizzata nei linguaggi *C-Like*.

```nasm
my_vector times 10 dw 0     ; definisco un vettore di 10 elementi con tutti 0
mov ebx, [my_vector]        ; carico in ebx l'indirizzo effettivo del vettore
mov [ebx], 110              ; equivale a: my_vector[0]=110 
add ebx, 2                  ; aggiungo 2 al registro ebx
mov [ebx], 123              ; equivale a: my_vector[2]=123
```

Si noti come in questo caso il registro `[ebx]` funga da puntatore che va a modificare la locazione di memoria del nostro vettore in maniera indiretta.

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