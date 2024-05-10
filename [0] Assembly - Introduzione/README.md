# Assembly Course: Introduzione

- [Assembly Course: Introduzione](#assembly-course-introduzione)
- [Architetture CISC e RISC](#architetture-cisc-e-risc)
- [Cos'è l'assembly?](#cosè-lassembly)
- [L'assemblatore `NASM`](#lassemblatore-nasm)
  - [Installare NASM sui sistemi Linux](#installare-nasm-sui-sistemi-linux)
- [Linker e Loader (`ld`)](#linker-e-loader-ld)
- [Assembly: commenti](#assembly-commenti)
- [Assembly: le sezioni](#assembly-le-sezioni)
- [Assembly: sinstassi di base](#assembly-sinstassi-di-base)
  - [Istruzioni di base](#istruzioni-di-base)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Architetture CISC e RISC

Uno degli aspetti principali per la classificazione di un microprocessore è la sua **architettura**, negli anni sono state svariate le architetture progettate. 

Le CPU offrono un set di istruzioni con la quale programmare a basso livello la CPU questo set di istruzioni è tecnicamente detto **ISA** *(Instruction Set Architecture)*, lo ISA di una CPU varia in base all'architettura che implementa.

Le architetture si suddividono principalmente in due macro famiglie:

* **CISC** *(Complex Instruction Set Computer)* &rarr; Lo ISA delle architetture CISC era molto ampio, e di conseguenza complesso, tuttavia l'ampiezza delle istruzioni a disposizione garantisce un copertura su savriate operazioni possibili ad ogni singolo clock, alcuni esempi di architetture CISC:
  * `x86`  
  * `Motorola 68000`  
  * `Intel 8086`
* **RISC** *(Restricted Instruction Set Computer)* &rarr; La comunità informatica negli anni ha compreso che l'efficienza, e quindi le prestazioni, di un sistema migliorano all'aumentare della semplicità, dunque, poche istruzioni garantiscono semplicità d'uso ed efficienza maggiore, alcuni esempi di architetture RISC.
  * `MIPS` 
  * `ARM` 
  * `PowerPC`
  * `RISC-V`

I moderni processori come `intel` e `amd` si basano su un architettura `x86`, dunque il set di istruzioni è di tipo RISC.

# Cos'è l'assembly?

Il linguaggio **assembly** è un linguaggio di programmazione a [basso livello](https://it.wikipedia.org/wiki/Linguaggio_di_programmazione_a_basso_livello#:~:text=Un%20linguaggio%20di%20programmazione%20a,del%20funzionamento%20fisico%20del%20calcolatore.) che utilizza identificatori mnemonici per la stesura del codice sorgente. Il linguaggio assembly è un linguaggio molto vicino alla macchina ed è nato con l'esigenza di fornire a noi esseri umani un modo semplice per consentirci di programmare un computer, infatti come ben sappiamo le CPU delle nostre macchine conoscono solamente il codice binario ed ovviamente sarebbe molto complesso per gli umani scrivere codice in binario, per questo nasce l'assembly.

L'assembly si compone di una serie di istruzioni, ognuna delle quali corrisponde ad un istruzione del linguaggio macchina, ovvero il linguaggio binario della CPU che monta il nostro PC, in altre parole ogni processore o serie di processori gode di un proprio set di istruzioni scritte in linguaggio macchina *(binario)*, chi produce la CPU, per esempio **AMD** o **INTEL**, fornisce in corredo anche il relativo linguaggio assembly per quella famiglia di CPU, cosicché i programmatori possano scrivere comodamente codici sorgenti in assembly che verranno poi dati all'assembler che appunto assemblerà il tutto, traducendo tutte le istruzioni in istruzioni in linguaggio macchina comprensibili per la nostra CPU.

Fortunatamente negli ultimi anni si è venuta a creare una certa convenzione sui linguaggi assembly dei vari processori, dunque, passare dal linguaggio assembly di una CPU all'altro non è cosi complesso, tuttavia essendo così vicino all'hardware non vi è una grandissima portabilità del linguaggio, inoltre va specificato che è un linguaggio [non tipizzato](https://it.wikipedia.org/wiki/Tipizzazione_forte). Negli anni passati la distinzione tra le architetture era molto più netta, basti pensare alle famose CPU della famiglia `Motorola 68000` e di quelli della famiglia `Intel 8086` i cui linguaggi assembly avevano una sintassi molto diversa.

A questo punto viene da chiedersi perchè è importante imparare un linguaggio così specifico e a basso livello al giorno d'oggi, è vero che gli utilizzi dell'assembly nell'informatica moderna sono eccessivi per un programmatore ordinario, tuttavia conoscere il funzionamento di cosa avviene a basso livello è di fondamentale importanza per capire i meccanismi che regolano il funzionamento dei nostri computer e del come vengono effettivamente interpretati i codici sorgenti dalla CPU. Ovviamente al giorno d'oggi imparare l'assembly non ha solo una valenza prettamente didattica, infatti è ampiamente utilizzato nella stesura di codici che dovranno poi girare su sistemi embedded o nella implementazione dei vari compilatori che utilizziamo quando vogliamo compilari codici scritti nei vari linguaggi di programmazione.

# L'assemblatore `NASM`

Al giorno d'oggi abbbiamo a disposizione diversi assemblatori con cui compilare i nostri sorgenti assembly, tra quelli più famosi annoveriamo:

* **GAS** *(Gnu Assembler)* &rarr; Questo è l'assemblatore open source dei sistemi UNIX-Like, il suo utilizzo è dato dal comando `as` sui terminali Linux, tuttavia *GAS* è cross platform, dunque il codice assembly scritto per GAS è eseguibile su architetture diverse.

* **NASM** *(Netwide Assembler)* &rarr; Anche in questo caso si tratta di un software libero per lo sviluppo di programmi per architetture a `16bit`, `32bit` e `64bit`, sarà proprio questo l'assemblatore che utilizzeremo in questo mini corso.

## Installare NASM sui sistemi Linux

```shell
sudo apt update
```

```shell
sudo apt install nasm
```

Per accertarci dell'avvenuta installazione, possiamo invocare il comando che ci ritorna la versione di NASM che abbiamo installato con il comando:

```shell
nasm -v
```

# Linker e Loader (`ld`)

Un altro software che dovremmo utilizzare è il *linker and loader* di Linux, che possiamo utilizzare invocando il comando `ld` sul terminale, il suo utilizzo ci è utile per effettuare il linking di tutti i file oggetto generati dal compilatore, anche il compilatore `gcc` di C utilizza durante la fase di compilazione questo comando per effettuare il linking di tutte le librerie e file oggetto del nostro programma per poi ritornarci in output un file eseguibile.

# Assembly: commenti

Per inserire commenti all'interno dei nostri sorgenti assembly utilizziamo il carattere speciale `;` *(punto e virgola)*.

```nasm
; commento
mov eax, 10   ; commento
```

# Assembly: le sezioni

I nostri codici assembly per funzionare necessitano di una suddivisione dei principali blocchi di istruzione, principalmente le sezioni principali sono:

* `data`: Sezione in cui vengono dichiarate ed inizializzate le variabili utilizzate nel programma
* `bss`: Sezione in cui vengono dichiarate le variabili non inizializzate
* `text`: In questa sezione va scritto il codice vero proprio

dal punto di vista implementativo la sintassi risulta essere la seguente:

```nasm
section .data
  ; variabili inizializzate

section .bss
  ; variabili non inizializzate

section .text
  ; codice sorgente
```

# Assembly: sinstassi di base

Tutte le istruzioni mnemoniche del linguaggio assembly sono detti **opcode**, e la struttura di base di una riga di codice è:

```nasm
[label] opcode [operands] [eventuale commento]
```

E' fondamentale per il linker individuare il punto di ingresso del programma, di default la label di ingresso è chiamata `_start`, tuttavia è possibile cambiare il punto di ingresso ma dobbiamo poi ricordare di specificare il punto di ingresso da noi definito quando poi invocheremo il linker.

Di seguito un esempio della struttura di base di un codice assembly:

```nasm
section .data
  global _start

section .text
_start:
  ; codice del programma
```

Si noti l'utilizzo della keyword `global` con la quale si specifica che la label `_start` deve essere globalmente visibile da tutti i file oggetto che compongono il programma.

## Case sensitive

L'assembly non è *case sensitive* quando si tratta di implementare le istruzioni principali del linguaggio (`opcode`):

```nasm
; queste due sintassi sono equivalenti
MOV EAX, 10
mov eax, 10
```

Tuttavia è bene notare che sulla definizione delle `label` vi è la proprietà del case sensitive, infatti in quel caso bisogna fare attenzione:

```nasm
; queste label si riferiscono a tre indirizzi differenti
my_var
My_Var
MY_VAR
```

## Istruzioni di base

Nel linguaggio assembly vi sono svariati **opcode** che ci è consentito utilizzare, li vedremo in dettaglio nelle parti successive di questo corso, tuttavia al momento ne vediamo qualcuno:

| OPCODE | Descrizione | Categoria | Esempio di utilizzo |
|:------:|:-----------:|:---------:|:-------------------:|
| `mov` | Sposta informazioni da una posizione all'altra | Movimento dei dati | `mov edx, 10` <br> *carica il valore `10` nel registro `edx`* |
| `add` | Operatore di somma | Aritmetica | `add edx, 10` *somma `10` alle informazioni contenute nel registro `edx`* |
| `sub` | Operatore di differenza | Aritmetica | `sub edx, 10` *sottrae `10` alle informazioni contenute nel registro `edx`* |
| `mul` | Operatore di prodotto | Aritmetica | `mul edx, 10` *moltiplica per `10` le informazioni contenute nel registro `edx`* |
| `div` | Operatore divisione | Aritmetica | `div edx, 10` *divide per `10` le informazioni contenute nel registro `edx`* |

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