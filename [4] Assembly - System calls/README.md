# Assembly Course: System Call

- [Assembly Course: System Call](#assembly-course-system-call)
- [Cosa sono le System Call](#cosa-sono-le-system-call)
- [Struttura per l'utilizzo delle system call in Assembly](#struttura-per-lutilizzo-delle-system-call-in-assembly)
- [Compilare ed eseguire un sorgente `*.asm`](#compilare-ed-eseguire-un-sorgente-asm)
- [References](#references)
- [Author](#author)

# Cosa sono le System Call

Ogni qual volta che eseguiamo un operazione sensibile sul nostro PC, come per esempio la creazione di un file od anche solo stampare un messaggio sulla console, vengono utilizzati degli speciali servizi gestiti a livello Kernel nel sistema operativo, questo meccanismo garantisce il corretto funzionamento del sistema in generale. Quando per esempio programmiamo in `C` ed invochiamo la funzione `printf()` tutto quello che avviene a basso livello è la chiamata di una system call da parte del kernel chiamata `sys_write` che viene appunto utilizzata per stampare il messaggio desiderato sulla console di sistema.

Diversamente da come si può pensare moltissime sono le operazioni che svolgiamo quotidianamente che coinvolgono l'utilizzo delle system call.

Le system call in assembly assumono le fattezze di un valore intero, per esempio il valore intero `1` corrisponde alla system call `sys_write`.

# Struttura per l'utilizzo delle system call in Assembly

Per l'utilizzo delle system call in assembly NASM dobbiamo fare molta attenzione ai registri che utilizziamo, infatti ci sono specifici registri impiegati per esempio a contenere l'intero che definisce la system call che vogliamo utilizzare e poi a seguire una successione di scpecifici registri in cui inserire eventuali parametri di input per la system call in questione, di seguito un elenco di alcune delle system call disponibili per le architetture `x86-64` sotto i sistemi *UNIX-Like*, nella tabella sono specificati anche i vari registri da impiegare per eventuali parametri di ingresso.

| `%rax` | System Call | Descrizione | `%rdi` | `%rsi` | `%rdx` | `%r10` | `%r8` | `%r9` |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| `0` | `sys_read` | Apre uno stream in lettura su un file descriptor | `unsigned int file_descriptor` | `char* buffer` | `size_t count` |  |  |  |
| `1` | `sys_write` | Apre uno stream in scrittura su un file descriptor | `unsigned int file_descriptor` | `const char* buffer` | `size_t count` |  |  |  |
| `2` | `sys_open` | Apre o crea un file | `const char* file_name` | `int flags` | `int mode` |  |  |  |
| `3` | `sys_close` | Chiude lo stream su un file descriptor | `unsigned int file_descriptor` |  |  |  |  |  |
| `4` | `sys_stat` | Resituisce informazioni su un file | `const char* file_name` | `struct stat* stat_buffer` |  |  |  |  |
| `5` | `sys_fstat` | Resitutisce informazioni su un file aperto | `unsigned int file_descriptor` | `struct stat* stat_buffer` |  |  |  |  |
| `6` | `sys_lstat` | Resitutisce informazioni su un symbolic link | `const char* file_name` | `struct stat* stat_buffer` |  |  |  |  |
| `7` | `sys_poll` | Esamina un insieme di file descriptor per eventi I/O | `struct poll_fd* ufds` | `unsigned int nfds` | `long timeout_msecs` |  |  |  |
| `8` | `sys_lseek` | Gestisce la posizione del cursore in un file di testo | `unsigned int file__descriptor` | `off_t offset` | `unsigned int origin` |  |  |  |
| `12` | `sys_brk` | Imposta il segmento di fine di un processo | `unsigned long brk` |  |  |  |  |  |
| `19` | `sys_readv` | Legge dati da più buffer associati ad un file descriptor in un'unica chiamata | `unsigned long file_descriptor` | `const struct iovec* vec` | `unsigned long vlen` |  |  |  |
| `21` | `sys_access` | Controlla i permessi di accesso di un file | `const char* file_name` | `int mode` |  |  |  |  |
| `22` | `sys_pip` | Crea una coppia di file descriptor utilizzati per una pipe | `int* filedes` |  |  |  |  |  |
| `32` | `sys_dup` | Duplica un file descriptor esistente | `unsigned int filedes` |  |  |  |  |  |
| `33` | `sys_dup2` | Duplica un file descriptor esistente su un altro file descriptor specificato | `unsigned int old_fd` | `unsigned int new_fd` |  |  |  |  |
| `34` | `sys_pause` | Mette in pausa il processo fino alla ricezione di un segnale | | |  |  |  |  |
| `35` | `sys_nanosleep` | Sospende il processo per un periodo specificato di tempo | `struct timespec* rqtp` | `struct timespec* rmtp` |  |  |  |  |
| `37` | `sys_alarm` | Imposta un timer di sveglia che invia un segnale al processo dopo un certo numero di secondi | `unsigned int seconds` | |  |  |  |  |
| `48` | `sys_shutdown` | Chiude parte di una connesione di rete | `int file_descriptor` | `int how` |  |  |  |  |
| `60` | `sys_exit` | Termina il processo e ritorna un eventuale codice di errore | `int error_code` | |  |  |  |  |
| `63` | `sys_uname` | Fornisce informazioni sul sistema operativo in utilizzo | `struct old_utsname* name` | |  |  |  |  |
| `80` | `sys_chdir` | Cambia la directory di lavoro corrente | `const char* filename` | |  |  |  |  |
| `82` | `sys_rename` | Rinomina un file o una directory | `const char* old_name` | `const char* new_name` |  |  |  |  |
| `83` | `sys_mkdir` | Crea una nuova cartella | `const char* path_name` | `int mode` |  |  |  |  |
| `84` | `sys_rmdir` | Rimuove cartella | `const char* path_name` | |  |  |  |  |
| `85` | `sys_creat` | Crea un nuovo file | `const char* path_name` | `int mode` |  |  |  |  |
| `90` | `sys_chmod` | Modifica i permessi per un file o una directory | `const char* file_name` | `mode_t mode` |  |  |  |  |
| `200` | `sys_tkill` | Invia un segnale `sig` ad un processo specificato *(con il PID)* | `pid_t pid` | `int sig` |  |  |  |  |

**IMPORTANTE**: Una volta settati tutti i registri per una specifica system call possiamo eseguire l'istruzione `syscall` per eseguire quella system call con i parametri da noi settati.

**IMPORTANTE**: Se si sta scrivendo codice sorgente assembly per architetture `32bit`, allora, non sarà possibile invocare le system call con l'istruzione `syscall`, ma si utilizza l'invocazione alla interrupt `int 0x80`.

⚠: L'elenco completo delle system call per le architetture `x86-64` è consultabile [qui](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/).

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