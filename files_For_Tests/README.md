# TP-Batch-Ms-Windows

Programme développé dans le cadre d'un cours intitulé « Système d'exploitation et réseaux informatiques » de la filière [M1 DCISS](http://www.upmf-grenoble.fr/formation/les-diplomes/master-double-competence-informatique-et-sciences-sociales-dciss-p--8465.htm) de l'Université Grenoble 2.

## Requierments 


Testé et développé sous Windows XP SP3 édition familiale en 2015 par Juanes852.

***Attention, encodage `cp850`***, il permet d'afficher des accents dans la console Windows. Encodage non pris en charge par Notepad++ et Sublime Text, mais bien pris en charge par Vim. Sous Vim, taper `e ++enc=cp850` juste après l'ouverture du fichier. *Encodage également pris en charge par Microsoft Word*, détécté automatiquement à l'ouverture du fichier. En l'absence de Microsoft Word et, possibilité de l'ouvrir avec le logiciel Dos « Edit » disponible sous Windows XP mais plus sous Windows Seven.


## Overview

Liste de scripts ordonnée en fonction du nombre de dépendances de chaque script. <br />
Tous les scripts ont été écris pour exécuter `CalculerResultat.bat`, celui-ci est dépendant de tous les autres programmes. En fin de liste, `anneeBissextile.bat` n'est dépendant d'aucun autre script.

## CalculerResultat.bat

 Ce programme concerne la gestion d'une épreuve de lancé de Javelot. Durant cette compétition, chaque athlète a eu 3 essais.

 Affiche, pour chaque athlète du fichier passé en paramètre, sa catégorie d'âge et son meilleur lancé. 

Le fichier passé en paramètre doit être formaté de la manière suivante :  
```
# Fichiers des athletes [commentaire non pris en compte] 
Galle:Martin:12-2-1991:94:87:100 
Honnete:Marie:4-12-1950:98:100:10
```
## AfficherResultat.bat

Affiche la catégorie et le meilleur lancé d'un athlète de javelot donné. Par exemple, la commande `AfficherResultat Martin Galle 12-2-1991 94 87 93` a pour effet d'afficher : « Le meilleur lancé de Martin Galle, membre de la catégorie des « Séniors », est de 94 m. ». Autour du résultat, affiche également un header et un footer commencés par le caractère « - », ainsi que des lignes blanches.

Si le nombre d'arguments est invalide, renvoie un code d'erreur de « 2 » si c'est .\Categorie.bat qui a échoué renvoie « 3 », si c'est .\Maximum.bat  qui échoue renvoie « 4 », si c'est dateValide.bat qui échoue renvoie le code d'erreur 5. Dans tous les cas affiche un message d'erreur dans stderr très contextualisé.

Le deuxième argument devra comporter entre six et dix caractères. Ainsi, écrire 2-2-1991 ne provoquera pas d'erreur.

Ce programme a été implémanté pour que que les distances puissent être des flotants.

### Categorie.bat

 Ce programme calcule la variable d'environnement %CATEG% et afficha la catégorie d'âge d'un athlète. Cette commande doit prendre en paramètre une année comprise entre 1905 et 2099, la catégorie d'âge retournée est une de celles de la fédération française d'athlétisme. Autour du résultat affiché, affiche également un header et un footer commencés par le caractère « - », ainsi que des lignes blanches.

 Si l'argument n'est pas valable, affiche dans stderr un message d'erreur très contextualisé et renvoie le code d'erreur « 3 ».

### Maximum.bat

Ce programme permet d'afficher le maximum d'une liste d'entiers ou de flotants passés en paramètres. Le nombre de paramètres n'est pas fixe. Autour du résultat, affiche également un header et un footer commencés par le caractère « - », ainsi que des lignes blanches.

Si l'argument n'est pas valable, affiche dans stderr un message d'erreur contextualisé et renvoie le code d'erreur « 4 ». Le nombre doit avoir au maximum 10 chiffres avant avant et après le point, si il en a plus ce programme indique que l'argument n'est pas valable et se termine. 

### dateValide.bat

 Ce programme permet de savoir si une date passée en paramètres est valide. La date doit être entrée sous la forme j-m-aaaa ou jj-m-aaaa ou j-mm-aaaa ou jj-mm-aaaa. L'année doit être postérieure à 1582. Prend en compte le faite qu'une année soit bissextile ou non. Par exemple, `dateValide 29-2-2015` affiche un message d'avertissment.

 Autour du résultat, affiche également un header et un footer commencés par le caractère « - », ainsi que des lignes blanches.

 Si l'argument n'est pas valable, affiche dans stderr un message d'erreur contextualisé et renvoie le code d'erreur « 6 ».

## anneBissextile.bat

Ce programme permet de savoir si une année entrée en paramètre est bissextile. Rappel, une année est bissextile si elle est divisible par 400, ou si elle est divisible par 4 mais pas par 100, et ce depuis 1582. Autour du résultat, affiche également un header et un footer commencés par le caractère « - », ainsi que des lignes blanches. Si l'année est bissextile, %estBissextile%==1, sinon %estBissextile%==0.

 Si l'argument n'est pas valable, affiche dans stderr un message d'erreur contextualisé et renvoie le code d'erreur « 6 ».

## Version 

Dévoloppement : octobre-novembre 2015. Première publication : novembre 2015.


 ## Licence 

The MIT License (MIT)

Copyright (c) 2015 juanes852

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

