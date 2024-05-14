# Assembly Course: Registri

- [Assembly Course: Registri](#assembly-course-registri)
- [Le variabili](#le-variabili)
- [Dichiarazione di variabili non inizializzate](#dichiarazione-di-variabili-non-inizializzate)
- [Inizializzazione di variabili mediante differenti codifiche](#inizializzazione-di-variabili-mediante-differenti-codifiche)
    - [Inizializzazioni Multiple](#inizializzazioni-multiple)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Le variabili

Programmare in Assembly ci vincola a fare un buon uso delle risorse a disposizione, infatti a differenza di un moderno linguaggio con un alto livello di astrazione, nell'assembly dobbiamo gestire con parsimonia le varibile necessarie per il nostro programma, lo scopo ultimo è infatti quello di ottimizzare il programma che scriviamo per essere i lpiù efficienti possibili.

Quando dichiariamo una variabile in assembly dobbiamo specificare il quantitativo di byte che ci aspettiamo che quella variabile occupi, nello specifico utilizziamo delle specifiche keyword che definiscono proprio il numero di byte necessari alla variabile.

| Keyword | Description | Size |
|:-------:|:-----------:|:----:|
| `DB` | Definisce un byte | $1 bytes$ |
| `DW` | Definisce lo spazio per una word | $2 bytes$ |
| `DD` | Definisce lo spazio per un double word | $4 bytes$ |
| `DQ` | Definisce lo spazio per un quad word | $8 bytes$ |
| `DT` | Definisce lo spazio per un ten bytes | $10 bytes$ |
| `EQU` | Definisce una costante  |  |

Sulle variabili in questione ci sono alcune considerazioni da fare:

* Ogni carattere di una stringa è memorizzato in memoria in codifica `ASCII` in esadecimale
* Ogni valore decimale è direttamente convertito in un valore 16 bit e memorizzato in memoria in esadecimale
* Il processore utilizza un criterio *little endian*
* I numeri negativi sono rappresentati con il sistema numerico **complemento a 2**
* I valori floating point sono rappresentati in memoria con il sistema numerico `IEEE-754`
* In assembly non parliamo prettamente di variabili, ma di **label**, infatti quello che facciamo noi è fissare delle etichette a delle specifiche aree di memoria che contengono le nostre informazioni

# Dichiarazione di variabili non inizializzate

Non è raro avere l'esigenza di dover creare variabili senza inizializzarle e anche in questo caso essendo a basso livello dobbiamo utilizzare delle specifiche keyword per farlo.

| Keyword | Description | Size |
|:-------:|:-----------:|:----:|
| `RESB` | Riserva un byte | $1 bytes$ |
| `RESW` | Riserva lo spazio per una word | $2 bytes$ |
| `RESD` | Riserva lo spazio per un double word | $4 bytes$ |
| `RESQ` | Riserva lo spazio per un quad word | $8 bytes$ |
| `REST` | Riserva lo spazio per un ten bytes | $10 bytes$ |

# Inizializzazione di variabili mediante differenti codifiche

Risulta essere molto comodo dichiarare valori in differenti codifiche, anche solo per una questione di comodità, come vedremo nella tabella a seguire non ci sono molte possibilità a disposizione.

| Codifica | Esempio di utilizzo | Corrispettivo decimale |
|:-:|:-:|:-:| 
| ASCII | `var DB 'a'` | `97` |
| Decimale | `var DB 10D` | `10` |
| Esadecimale | `var DB 0AH` | `10` |
| Esadecimale | `var DB 0x0A` | `10` |
| Binario | `var DB 0b1010` | `10` |

# Gli array in assembly

Anche il linguaggio assembly ci permette di inizializzare o di riservare segmenti contigui di memoria, in modo da poter creare delle vere e proprie collezioni di dati omogenei, cosi come accade nei linguaggi di programmazione convenzionali come il `C`.

Di seguito un esempio di inizializzazione e di accesso ad un vettore:

```nasm
section .text
    mov rcx, [vector_byte+3]      ; prendi elemento in posizione 3 del vettore
    mov rcx, [vector_word+4]      ; una word è 2byte, quindi l'offset è a step di 2 
    mov rcx, [repeated_value+2]   ; una word è 2byte, quindi l'offset è a step di 2

section .data
    vector_byte db 3,4,5,6,7     ; inizializza vettore di byte
    vector_word dw 1,2,3,4       ; inizializza vettore di word
    repeated_value times 5 db 2  ; vettore di 5 elementi inizilizzati a 2

section .bss
    empty_vector resb 4          ; dichiara un vettore di dimensione 4 non inizializzato
```

Dall'esempio di cui sopra si noti come si utilizzi lo scostamento *(offset)* per spostarsi tra i vari elementi del vettore, quindi, bisogna fare molta attenzione alla dimensione dei dati che si stanno memorizzando, se per esempio il nostro vettore è una collezione di `word`, allora, lo offset è a step di `2` byte per volta.

## Inizializzazioni Multiple

Possiamo utilizzare la keyword `times` per inizializzare una sequenza di informazioni ripetute, per esempio nel caso in cui volessimo inizializzare un vettore da $n$ elementi tutti con lo stesso valore.

Nell'esempio a seguire vi è una inizializzazione di un array di $10$ elementi di tipo `byte` in cui tutti gli indici del vettore sono posti a $1$:

```bash
section .data
    array times 10 DB 1
```

# Compilare ed eseguire un sorgente `*.asm`

```bash
nasm -f elf64 main.asm
```

```bash
ld main.o -o program_name
```

```bash
./program_name
```

Una volta eseguito questo programma non ci verrà mostrato nulla sullo schermo, perchè il nostro programma non fa altro che ritornare un valore al termine del programma attraverso la system call `sys_exit`, pertanto, dopo aver eseguito il programma possiamo eseguire un comando del terminale *Linux* che ci permette di vedere il valore di ritorno dell'ultimo programma eseguito sul terminale, il comando in questione è:

```shell
echo $?
```

Se tutto è andato bene, sulla console dovremmo vedere il valore intero che abbiamo inserito nella variabile `exit_value` nel nostro codice sorgente

# References

[NASM](https://www.nasm.us/)

[Sistema Numerico "Complemento a 2"](https://it.wikipedia.org/wiki/Complemento_a_due)

[Sistema Numerico "IEEE-754"](https://it.wikipedia.org/wiki/IEEE_754)

[Little Endian](https://en.wikipedia.org/wiki/Endianness)

# Author

Emilio Garzia, 2024