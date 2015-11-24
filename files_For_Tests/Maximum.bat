::                            -------------------
::                            |  DM de SystŠme  |
::                            |    Juanes852 |
::                            |      M1 DCISS   |
::                            |     07/11/2015  |
::                            -------------------


:: Ce programme permet d'afficher le maximum d'une liste d'entiers ou de flotants pass‚s en paramŠtres. Le nombre de paramŠtres n'est pas fixe. Autour du r‚sultat, affiche ‚galement un header et un footer commenc‚s par le caractŠre ®ÿ-ÿ¯, ainsi que des lignes blanches.
:: Si l'argument n'est pas valable, affiche dans stderr un message d'erreur contextualis‚ et renvoie le code d'erreur ®ÿ4ÿ¯. Le nombre doit avoir au maximum 10 chiffres avant avant et aprŠs le point, si il en a plus ce programme indique que l'argument n'est pas valable et se termine. 


:: Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par Juanes852.
:: Test bon encodageÿ: ‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚
:: ATTENTION, ENCODAGE cp850, il permet d'afficher des accents dans la console Windows. Encodage non pris en charge par Notepad++, mais bien pris en charge par Vim. Sous Vim, taper ®ÿ: e ++enc=cp850ÿ¯ juste aprŠs l'ouverture du fichier. ENCODAGE GALEMENT PRIS EN CHARGE PAR MICROSOFT WORD, DTCT AUTOMATIQUEMENT · L'OUVERTURE DU FICHIER. En l'absence de Microsoft Word et, possibilit‚ de l'ouvrir avec le logiciel Dos ®ÿEditÿ¯ disponible sous Windows XP mais plus sous Windows Seven.
@echo off
echo. & echo. & echo.
echo ------------ Maximum.bat -----------
echo. & echo.
setlocal enabledelayedexpansion

::Permet d'afficher un message d'erreur si on n'a pas entr‚ assez d'arguments.
if "%1"=="" (
    goto usageNbrArg )
    )
::Permet d'afficher l'aide si le premier argument est "/?"
if "%1"=="/?" (
    goto usage 
    )

:: Iø D‚but de la partie principale du programme.
:: ------------------------------------------
:: ------------------------------------------
:: ------------------------------------------
:: On d‚finit %1 comme le nombre maximum. Grƒce a shift, on attribut %1<--%X, ou X represente l'argument suivant non encore utilis‚. Ensuite, on compare %1 et %MAXI%, si %1>%MAXI%, alors %MAXI%<--%1. Si %1 comporte une chaŒne vide, alors on termine la boucle, et on affiche le nombre maximum trouv‚.
set MAXI=%1
::Debut de la boucle de recherche du nombre maximum.
:: ----
:: ----
:repeter
:: Programmation d‚fensive effectu‚e … chaque it‚ration.
:: ----
:: Programmation d‚fensive. · chaque it‚ration, on v‚rifie que %1 est bien un flotant ou un entier. Si c'est un caractŠre, ‡a va … l'‚tiquette usageArgCaractere.
set testNombre=%1
:: … la fin de la boucle, si %testNombre%==10.1, alors %partEntiere%==10, et"%decimale%"=="1". Si %testNombre%==10, alors %partEntiere%=10, "%decimale%"=="". Si on met delims avant tokens, ‡a plante.
for  /f "tokens=1,2,3 delims=." %%a in ("!testNombre!") do (
      set partEntiere=%%a
      set decimale=%%b
    :: Si %testNombre% est de la forme 10.1.1, va … l'‚tiquette goto usageArgCaractere.
    if not "%%c" == "" (
      goto usageArgCaractere
      )
    )
if not "!decimale!"=="" (
  :: Si !decimale! n'est pas un entier, l'op‚ration attribue 0 … la variable !Evaluated!. Fonctionne avec les entiers n‚gatifs. Suppression de l'espace situ‚ avant le ® %decimale% ¯. Cet espace r‚sulte de la pr‚c‚dente boucle for.
  set decimale=!decimale: =!
  :: Si %varTmp% n'est pas un entier, l'op‚ration attribue 0 … la variable %Evaluated%. Si %varTmp% est un flottant du type ®ÿ10.1ÿ¯, ou mˆme ®ÿ10.…ÿ¯, l'op‚ration attribue la valeur tronqu‚e de %varTmp%, provoque la lev‚e d'une exception non fatale ®ÿop‚rande manquanteÿ¯ (ici redirig‚e vers /Nul). Dans cet exemple-ci, vu que 10 non= 10.1, on va … l'‚tiquette usageArgCaractere. D'aprŠs mes recherches, batch ne supporte pas les op‚rations arithm‚tiques (d‚finies par /a) sur des flotants. Fonctionne avec les entiers n‚gatifs. Si le chiffres comporte plus de 10 chiffres, attribue 1 … %Evaluated%, et l'‚galit‚ suivante n'est plus vraie.
  set /a Evaluated=!decimale! 2> /NUL 
  if not !Evaluated! EQU !decimale! (
      goto usageArgCaractere
    )
  :: Les d‚cimales doivent correspondre … des entiers positifs. Dans !testDecimaleNeg!, supression de tout ‚ventuel signe moins. 
  set testDecimaleNeg=!decimale:-=x!
  :: Si on d‚cecte une diff‚rence, c'est que y'avait un ®ÿ-ÿ¯.
  if not "!testDecimaleNeg!"=="!decimale!" (
    goto usageArgCaractere
    )
  )
set /a Evaluated=!partEntiere! 2> /NUL 
if not !Evaluated! EQU !partEntiere! (
    goto usageArgCaractere
    )
:: Fin de la programmation d‚fensive.
:: ------
:: D‚but de la boucle qui permet de d‚terminer si la nouvelle valeur de %1 est oui ou non sup‚rieure au nom‚ro maximum trouv‚ jusque-l…. 
:: ---------
if /i %1 GTR !MAXI! (
    set MAXI=%1
    )
shift
if not "%1"=="" (
    goto repeter 
    )

set MAXI=%MAXI%
::Fin de la boucle de recherche du nombre maximum.
:: -----
:: Affichage du r‚sultatÿ:
echo Le nombre maximum est %MAXI%.

:: http://stackoverflow.com/questions/3262287/make-an-environment-variable-survive-endlocal
:: A FOR expression is an excellent choice to transport a value across the ENDLOCAL barrier if you are concerned about special characters. Delayed expansion should be enabled before the ENDLOCAL, and disabled after the ENDLOCAL.
for /f "delims=" %%A in ("!MAXI!") do (
    endlocal
    set MAXI=%%A
  )

goto fin
:: Fin du Programme
:: ----------------
:: ----------------
:: ----------------


:: IIø tiquettes de fin de programme
:: ------------------------------
:usageNbrArg 
echo        Nombre d'arguments invalide. Vous devez entrer au moins un nombre entier ou flotant avec au maximum 10 chiffres aprŠs le point. 1>&2
goto finError

:usageArgCaractere
echo        Argument %1 invalide, vous n'avez pas entr‚ uniquement des nombres. Vous ne pouvez entrer qu'une suite de nombres entiers ou flotant avec au maximum 10 chiffres avant et aprŠs la virgule. 1>&2
goto finError

:usage 
echo Permet d'afficher le maximum d'une liste d'entiers ou de flotants pass‚s en paramŠtres. Il ne peut y avoir plus de 10 chiffres avant et aprŠs le point. Le nombre de paramŠtres n'est pas fixe.
echo Si l'argument n'est pas valable, affiche dans stderr un message d'erreur contextualis‚ et renvoie le code d'erreur ®ÿ4ÿ¯.
echo Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par Juanes852.
goto fin

:finError
echo. & echo.
echo ------------------------------------
echo. & echo. & echo.
exit /b 4


:fin
echo. & echo.
echo ------------------------------------
echo. & echo. & echo.
exit /b 0
