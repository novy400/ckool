# CKOOL 

Le programme de service CKOOL regroupe des procédures qui peuvent faciliter vos développements.

## Installation

//to be DONE

## Procedures

### CKOOL_writeJoblog : pour ecrire un message dans la log du job.

```CKOOL_writeJobLog( 'Write this data ' + %char(toto)); ```

utilisable aussi via la commande

```CKLOGMSG MSG('Write this data')```

### CKOOL_displayLongMessage : pour afficher un long message à l'écran.

```CKOOL_displayLongMessage( 'Bonjour ceci est un long message ' + %char(toto)); ```

utilisable aussi via la commande

```CKLONGMSG MSG('Write this data')```

### CKOOL_throw : pour lever une exception.

```CKOOL_throw('test throw'); ```

un exemple de le programme CKERROR utilisable aussi via la commande

```CKERROR```

### CKOOL_catch : pour attraper une exception.

```clear lMsg;```
```lMsg = CKOOL_catch();```

un exemple de le programme CKERROR utilisable aussi via la commande

```CKERROR```
