# Assembly Course: Registri

- [Assembly Course: Registri](#assembly-course-registri)
- [Registri General Purpose](#registri-general-purpose)
- [Registro `EFLAGS`](#registro-eflags)
- [Registro `IP`](#registro-ip)
- [Registri di segmentazione](#registri-di-segmentazione)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Registri General Purpose

In linguaggio Assembly è fondamentale comprendere il funzionamento dei registri, nello specifico, tutte le variabili e le operazioni che vogliamo eseguire necessitano dell'impiego dei registri. A disposizione abbiamo una grande quantità di registri, in particolare abbiamo  $16$ registri per il general purpose a 64 bit *(nel caso di assembly x64)*, possiamo inoltre accedere anche a delle sotto parti di un registro, per esempio, è possibile usare solamente `8bit`, `16bit`, `32bit` ed ovviamente anche tutti e `64bit` del registro in questione, ogni registro è definito da un proprio opcode, incluse le sue sotto parti, di seguito una tabella che mostra i nomi di tutti i registri e le relative sotto parti.

I principali $8$ registri GPR sono:

| `64bit` | `32bit` | `16bit` | `8bit` |
|:-------:|:-------:|:-------:|:------:|
| `rax` | `eax` | `ax` | `al` |
| `rcx` | `ecx` | `cx` | `cl` |
| `rdx` | `edx` | `dx` | `dl` |
| `rbx` | `ebx` | `bx` | `bl` |
| `rsi` | `esi` | `si` | `sil` |
| `rdi` | `edi` | `di` | `dil` |
| `rsp` | `esp` | `sp` | `spl` |
| `rbp` | `ebp` | `bp` | `bpl` |

poi ci sono altri $8$ registri GPR, anch'esso a `64bit`:

| `64bit` | `32bit` | `16bit` | `8bit` |
|:-------:|:-------:|:-------:|:------:|
| `r8` | `r8d` | `r8w` | `r8b` |
| `r9` | `r9d` | `r9w` | `r9b` |
| `r10` | `r10d` | `r10w` | `r10b` |
| `r11` | `r11d` | `r11w` | `r11b` |
| `r12` | `r12d` | `r12w` | `r12b` |
| `r13` | `r13d` | `r13w` | `r13b` |
| `r14` | `r14d` | `r14w` | `r14b` |
| `r15` | `r15d` | `r15w` | `r15b` |

Utilizziamo i registri GPR per memorizzare i valori delle variabili o dei valori temporanei, mentre quelli speciali si utilizzano prettamente per le loro specifiche funzioni.

## Approfondimenti: riconoscere i registri

A prima vista i nomi dei registri possono sembrare anonimi e privi di significato ma in realtà dicono molto sulla natura del registro, comprendere i nomi ci aiuta anche a memorizzarli meglio e ad avere una padronanza maggiore sul come impiegarli.

In particolare i singoli registri sono impiegati per scopi specifici, di seguito una breve descrizione su ognuno di essi:

1. **Accumulator Register** `AX` &rarr; Utilizzato nelle operazioni aritmetiche
1. **Base Register** `BX` &rarr; Utilizzato come puntatore ai dati
1. **Counter Register** `CX` &rarr; Utilizzato con le operazioni di shifting e nei loop
1. **Stack pointer Register** `SP` &rarr; Puntatore alla testa dello stack, ovvero alla prossima istruzione del programma da eseguire
1. **Stack Base pointer Register** `BP` &rarr; Utilizzato come puntatore alla base dello stack
1. **Destination index register** `DI` &rarr; Utilizzato come puntatore alla destinazione nelle operazioni di stream
1. **Source index register** `SI` &rarr; Utilizzato come puntatore alla sorgente nelle operazioni di stream
1. **Data register** `DX` &rarr; Utilizzato nelle operazioni aritmetiche e nelle operazioni I/O

Per quanto riguarda le nomenclautre, è possibile individuarli in base alla porzione di registro a cui vogliamo accedere:

* `R`: Quando vogliamo accedere a tutti e `64bit` del registro anteponiamo la `R`, per esempio `RAX` per i $64bit$ del registro `AX`
* `E`: Quando vogliamo accedere ai `32bit` del registro anteponiamo la `E` che sta per *extended*, per esempio `EAX` per i $32bit$ del registro `AX`
* `default` : Di default i registri sono considerati di `16bit`, quindi, per esempio il registro `AX`, bha una dimensione di `16bit`
* `H`, `L`: I registri che terminano con `H` o `L` sono di dimensioni di `8bit`ciascuno  e corrispondono rispettivamente alla parte più significativa *(high)* e alla parte meno significativa *(low)* del registro

# Registro `EFLAGS`

Il registro dei flag è un particolare registro nella quale specifici bit dei $64$ che lo compongono contengono informazioni di stato circa le operazioni che vengono svolte durante l'esecuzione del programma, per esempio, vi è un bit nel registro chiamato `ZF` *(Zero flag)* che viene settato a `1` se eseguiamo una divisione per zero, come vedremo ci sono molti bit che mostrano svariati flag.

Il nome EFLAGS sta per *Extended Flags Register* ed è per l'appunto una verione estesa del registro flag presente sulle architetture a `32bit` che nelle più moderne architetture `x86-64bit` si estende fino a $64bit$.

| 63-22 | 21 | 20 | 19 | 18 | 17 | 16 | 15 | 14 | 13-12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
| `0` | `ID` | `VIP` | `VIF` | `AC` | `VM` | `RF` | `0` | `NT` | `IOPL` | `OF` | `DF` | `IF` | `TF` | `SF` | `ZF` | `0` | `AF` | `0` | `PF` | `1` | `CF` |

> Rappresentazione del registro EFLAGS e di cosa contiene ogni singolo bit

⚠️: I bit posti a `0` e ad `1` sono bit del registro che non sono modificabili e che restano cosi come sono, soprattutto quelli aggiuntivi che vanno dal bit `32` a `64` sono posti tutti a zero per eventuali flag futuri

Di seguito vediamo la descrizione di tutti i bit di interesse del registro `EFLAGS`:

| bit | flag | nome esteso | descrizione |
|:---:|:----:|:-----------:|:-----------:|
| `0` | `CF` | *Carry Flag* | Viene settato a `1` quando quando viene eseguito un riporto da un operazione di addizione o sottrazione tra due valori binari |
| `2` | `PF` | *Parity Flag* | Viene settato a `1` quando il risultato di una operazione è un numero pari |
| `4` | `AF` | *Adjust Flag* | Utilizzato per le operazioni tra numeri *[BCD](https://it.wikipedia.org/wiki/Binary-coded_decimal) (Binary Coded Decimal)* quando si ha un resto proprio come per il bit `PF` |
| `6` | `ZF` | *Zero Flag* | Settato a `1` quando viene eseguita una divisione per zero |
| `7` | `SF` | *Sign Flag* | Settato a `1` se il segno del valore dell'ultima operazione è negativo |
| `8` | `TF` | *Trap Flag* | Settato a `1` se siamo in modalità debug istruzione per istruzione |
| `9` | `IF` | *Interruption Flag* | Settato a `1` se le interrupts sono abilitate |
| `10` | `DF` | *Direction Flag* | Utilizzato per le operazioni sulle stringhe per definire la direzione di movimento dei dati |
| `11` | `OF` | *Overflow Flag* | Settato a `1` se l'ultima operazione ha scaturito un overflow di memoria |
| `12-13` | `IOPL` | *I/O Privilege Level Field* | Mostra i privilegi sulle operazioni I/O del processo corrente |
| `14` | `NT` | *Nested Task Flag* | Se settato a `1`, allora, il processo supporta il cambio di contesto, quindi è in grado di abilitare o disabilitare task nidificati |
| `16` | `RF` | *Resume Flag* | Se avviene un eccezione del debugger mentre `RF` è settato a `1`, la CPU non esegue la prossima istruzione e setta a `1` il campo `TF` |
| `17` | `VM` | *Virtual 8086 Mode* | Settato a `1` se siamo in modalità di compatibilità con il processore `Intel 8086` |
| `18` | `AC` | *Alignment Check* | Settato a `1` quando la CPU esegue operazioni di allineamento della memoria, ovvero quando un istruzione tenta di accedere ad aree di memoria non di sua comptenza |
| `19` | `VIF` | *Virtual Interrupt flag* | Se settato a `1`, allora, la CPU accetta interruzioni virtuali, ovvero interruzioni che arrivano da un utente guest in un ambiente di OS virtualizzato |
| `20` | `VIP` | *Virtual Interrupt Pending flag* | Se settato a `1`, allora, significa che ci sono interruzioni virtuali in sospeso |
| `21` | `ID` | *Identification flag* | Se settato a `1`, allora, è possibile utilizzare l'istruzione `CPUID` per ottenere informazioni sul processore |

# Registro `IP`

Il registro *Instruction Pointer* `IP` è il registro che regola il flusso del programma, in quanto in esso viene caricato man mano l'indirizzo di memoria della prossima istruzione da eseguire.

# Registri di segmentazione

Molte architetture `x86`, come *Windows* o *Unix*, utilizzano una struttura del codice basata sulla segmentazione del codice, in pratica questi registri suddividono la memoria principale *(RAM)* in blocchi di dimensioni fisse ed in ognuno di questi blocchi *(segmenti)* ospita uno specifico insieme di informazioni, come per esempio un blocco contenente codice, un altro per contenere variabili, ecc.

C'è da dire che l'approccio verso l'utilizzo dei registri di segmento non è più utilizzato, in quanto questo era un modus operandi sulle vecchie architetture `x86`, tuttavia è bene conoscere i meccanismi che li regolano.

Di seguito una tabella in cui sono mostrati tutti i registri di segmento che abbiamo a disposizione:

| Registro | Descrizione |
| :-: | :-: |
| Stack Segment `SS` | Puntatore alla memoria *stack* |
| Code Segment `CS` | Puntatore all'area di memoria che contiene il codice |
| Data Segment `DS` | Puntatore all'area di memoria che contiene le variabili |
| Extra Segment `ES` | Puntatore all'area di memoria che contiene le variabili extra |
| F Segment `FS` | Puntatore all'area di memoria che contiene altre variabili extra |
| G Segment `GS` | Puntatore all'area di memoria che contiene altre variabili extra |

> Per quanto riguarda i registri sui dati, il loro utilizzo va utilizzato solo quando il blocco precedente è saturo, nello sprcifico l'ordine da seguire è: `DS` &rarr; `ES` &rarr; `FS` &rarr; `GS`

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