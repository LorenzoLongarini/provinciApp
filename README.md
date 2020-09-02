
# provinciAppMc
  
**provinciApp** è la nostra idea di applicazione per la provincia di Macerata secondo il concorso *Un'app per la provincia di Macerata*.
Il progetto nasce da tre semplici studenti con molta voglia di divertirsi e mettersi in gioco.
Lo sviluppo dell'applicazione nasce dalla base dei requisiti richiesti dal concorso, arricchiti dalle nostre idee e competenze al fine di creare qualcosa di semplice ed intuibile, in grado di attrarre ogni fascia di età della nostra provincia.


 [**Obiettivi del concorso**](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)

 [**Introduzione all'utilizzo dell'applicazione**](https://github.com/GeremiaPompei/mc/blob/master/README.md#introduzione-allutilizzo-dellapplicazione)
  
### Obiettivi del concorso  
  *L’applicazione mobile dovrà presentare le seguenti caratteristiche tecniche:*  
  ```
• dovrà essere realizzata con linguaggio open source secondo modalità 
“cross-platform”, funzionando correttamente su dispositivi basati sia su 
sistema operativo iOS (versione 6 o superiore) che su Android (versione 3.2
 o superiore);  
```
***[La nostra proposta][1]***

```
• layout grafico progettato e realizzato per dispositivi mobile sia di tipo 
smartphone sia di tipo tablet;  
```
***[La nostra proposta][2]***
```
• dovrà utilizzare un sistema di caching delle informazioni multimediali per 
ottimizzare i tempi e le modalità di reperimento dei dati;  
```
***[La nostra proposta][3]***
```
• avere una dimensione al download compatibile con l’installazione via 3G;  
```
***[La nostra proposta][4]***
```
• funzionare anche in modalità off-line;  
```
***[La nostra proposta][5]***
```
• dovrà basarsi sull’utilizzo degli Opendata della provincia di Macerata, 
pubblicati e reperibili al link 'http://dati.provincia.mc.it', e potrà trattarsi
 di un’applicazione per la rappresentazione di dati geo-riferiti.
```
***[La nostra proposta][6]***

*Saranno ritenuti motivo di maggiore punteggio:*
```
• l’utilizzo dei sensori del dispositivo mobile (GPS, bussola, accelerometro, 
fotocamera, ecc.);  
```
***[La nostra proposta][7]***
```
• l’interoperabilità con il mondo dei social network: possibilità di interazione 
con le APP social presenti sui device, all’interno delle community di 
appassionati;  
```
***[La nostra proposta][8]***
```
• l’ottimizzazione dei tempi di risposta necessari ad un utilizzo
 dell’applicazione in mobilità minimizzando il consumo di banda mobile internet 
 e/o saturazione dell’accesspoint nel caso di wi-fi pubblico.
```
***[La nostra proposta][9]***

In seguito all'implementazione, abbiamo documento una guida all'utilizzo: [Introduzione all'utilizzo](https://github.com/GeremiaPompei/mc/blob/master/README.md#introduzione-allutilizzo-dellapplicazione)

## Introduzione all'utilizzo dell'applicazione
In questa sezione illustreremo come utilizzare provinciApp, mostrandone le varie funzionalità.
Per cominciare è bene fare una distinzione tra funzionamento online e funzionamento offline, in quanto alcune funzionalità dell'applicazione non possono essere eseguite senza una connessione ad internet. Nonostante questo, la sezione offline permette comunque di accedere ad informazioni salvate in precedenza.

[Torna alla Home](https://github.com/GeremiaPompei/mc/blob/master/README.md#provinciappmc)


## Flutter
[1]:https://github.com/GeremiaPompei/mc/blob/master/README.md#flutter
Lo sviluppo dell'applicazione è stato effettuato tramite l'utilizzo di **Flutter**, un framework open-source creato da Google per la creazione di interfacce native per iOS e Android.
**Dart** è il linguaggio che abbiamo scelto per il progetto, nato all'interno dell'IDE Intellij e simulato con Android Studio e ..

[Torna ad Obiettivi](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)

## Layout
[2]:https://github.com/GeremiaPompei/mc/blob/master/README.md#layout
Il linguaggio utilizzato ci ha permesso di creare un layout molto versatile e moderno, sfruttando quelli che sono i colori della provincia di Macerata, inoltre i dati organizzati secondo le informazioni del database sono stati organizzati in modo tale rendere semplice la fruizione degli stessi.

[Torna ad Obiettivi](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)

## Cache
[3]:https://github.com/GeremiaPompei/mc/blob/master/README.md#cache
Il sistema di caching impostato permette di accedere con molta più facilità alle ultime ricerche effettuate: in questo modo è possibile accedere alle informazioni con velocità maggiore e senza la necessità di una connessione dati attiva.

[Torna ad Obiettivi](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)

## Dimensione
[4]:https://github.com/GeremiaPompei/mc/blob/master/README.md#dimensione
La dimensione dell'applicazione è di circa 120Mb, ad indicare come, sebbene essa possegga una grande quantitità di dati frubili dall'utente, sia molto leggera e facilmente scaricabile con la sola connessione dati del proprio smartphone.

[Torna ad Obiettivi](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)

## Offline
[5]:https://github.com/GeremiaPompei/mc/blob/master/README.md#offline
All'interno dell'applicazione è possibile scaricare alcuni elementi ai quali è poi possibile accedere senza l'utilizzo della connessione ad internet. I dati salvati possono essere reperibili nell'apposita sezione alla quale è possibile accedere tramite il pulsante 'Offline' in alto a destra.

[Cliccare qui per il funzionamento](https://github.com/GeremiaPompei/mc/blob/master/README.md#introduzione-allutilizzo-dellapplicazione)

[Torna ad Obiettivi](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)

## Database
[6]:https://github.com/GeremiaPompei/mc/blob/master/README.md#database
L'organizzazione dei dati segue il modello del database fornito, inoltre la struttura del modeling all'interno del progetto rende facilmente possibile l'aggiunta di nuove informazioni, le quali verranno mostrate poi sul proprio smartphone.

[Torna ad Obiettivi](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)

## Gps
[7]:https://github.com/GeremiaPompei/mc/blob/master/README.md#gps
All'interno di **provinciApp** è possibile visualizzare la posizione dell'evento cercato tramite una mappa posizionata in fondo alla pagina aperta. Se presente all'interno del proprio smartphone sarà inoltre possibile aprire la mappa all'interno di *google maps*, così da avere informazioni aggiuntive relative alla posizione di ricerca in relazione a quella dell'utente.

[Cliccare qui per il funzionamento](https://github.com/GeremiaPompei/mc/blob/master/README.md#introduzione-allutilizzo-dellapplicazione)

[Torna ad Obiettivi](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)

## Social
[8]:https://github.com/GeremiaPompei/mc/blob/master/README.md#social
La funzionalità legata ai social consiste nella possibilità di condividere l'informazione cercata dall'utente nelle varie piattaforme social presenti all'interno del proprio smartphone.
Una volta condiviso l'evento, l'interazione sarà possibile attraverso un click sul link url.

[Cliccare qui per il funzionamento](https://github.com/GeremiaPompei/mc/blob/master/README.md#introduzione-allutilizzo-dellapplicazione)

[Torna ad Obiettivi](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)

## Connessione dati
[9]:https://github.com/GeremiaPompei/mc/blob/master/README.md#connessione-dati
.... da completare ...

[Torna ad Obiettivi](https://github.com/GeremiaPompei/mc/blob/master/README.md#obiettivi-del-concorso)
[prova](https://github.com/GeremiaPompei/mc/commit/8ed511bc328dbb89b816e17f95ba914e1adbd117#diff-0627b8b5553e696bf9f72d1ca085d57a)




### Authors
- [Geremia Pompei](https://github.com/GeremiaPompei)
- [Alex Pop](https://github.com/axel2104)
- [Lorenzo Longarini](https://github.com/LorenzoLongarini)
 
