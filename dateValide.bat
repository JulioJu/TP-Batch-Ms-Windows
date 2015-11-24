::                            -------------------
::                            |  DM de SystŠme  |
::                            |    juanes10 |
::                            |      M1 DCISS   |
::                            |     07/11/2015  |
::                            -------------------


:: Ce programme permet de savoir si une date pass‚e en paramŠtres est valide. La date doit ˆtre entr‚e sous la forme j-m-aaaa ou jj-m-aaaa ou j-mm-aaaa ou jj-mm-aaaa. L'ann‚e doit ˆtre post‚rieure … 1582. Prend en compte le faite qu'une ann‚e soit bissextile ou non. Par exemple, dateValide 29-2-2015 affiche un message d'avertissment.
:: Autour du r‚sultat, affiche ‚galement un header et un footer commenc‚s par le caractŠre ®ÿ-ÿ¯, ainsi que des lignes blanches.
:: Si l'argument n'est pas valable, affiche dans stderr un message d'erreur contextualis‚ et renvoie le code d'erreur ®ÿ6ÿ¯.

:: Ce programme nous a permis de constater … nouveau que le batch posait de nombreux problŠmes. On a remaqu‚ que quand on mettait les parenthŠses de fin de condition (if) le long de la marge de gauche, ‡a faisait planter le programme. Plus bas, on a pu lire ®ÿ29, commande invalideÿ¯. Ce problŠme a ‚t‚ corrig‚, et on a veill‚ … d‚coller les parenthŠses de la marge, au d‚triment de la lisibilit‚ du code.
:: On a ‚galement pu constater que nativement, quand on appelait un programme … l'int‚rieur d'une condition ®ÿifÿ¯, les variables cr‚es … l'int‚rieur du sous-programme n'‚tait pas utilisable, on ne pouvait pas r‚cup‚rer la variable %estBissextile%. On a ‚t‚ oblig‚ de d‚placer l'instruction ®ÿcallÿ¯ … l'ext‚rieur de la condition.

:: Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par juanes10.
:: Test bon encodageÿ: ‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚
:: ATTENTION, ENCODAGE cp850, il permet d'afficher des accents dans la console Windows. Encodage non pris en charge par Notepad++, mais bien pris en charge par Vim. Sous Vim, taper ®ÿ: e ++enc=cp850ÿ¯ juste aprŠs l'ouverture du fichier. ENCODAGE GALEMENT PRIS EN CHARGE PAR MICROSOFT WORD, DTCT AUTOMATIQUEMENT · L'OUVERTURE DU FICHIER. En l'absence de Microsoft Word et, possibilit‚ de l'ouvrir avec le logiciel Dos ®ÿEditÿ¯ disponible sous Windows XP mais plus sous Windows Seven.
@echo off
echo. & echo. & echo.
echo ------------ anneeBissextile.bat -----------
echo. & echo.

::Permet d'afficher l'aide si le premier argument est "/?"
if "%1"=="/?" (
    goto usage 
    )

:: Iø Programmation d‚fensive
:: -----------
:: -----------
::Permet d'afficher un message d'erreur si on a entr‚ trop ou pas assez d'arguments.
if "%1"=="" (
    goto usageNbrArg 
    )
if not "%2"=="" (
    goto usageNbrArg
    )


:: On d‚compose %1, de la forme jj-mm-aaaa.
set premierArgument=%1
for /f "tokens=1,2,3 delims=-" %%G in ("%premierArgument%") do (
    set jour=%%G
    set mois=%%H 
    set annee=%%I
    )

:: Si on n'a pas entr‚ un argument de la forme jj-mm-aaaa, on va … l'‚tiquette usageNonDatejjmmaaaa.
if "%jour%"=="" (
    goto usageNonDatejjmmaaaa
    )
if "%mois%"=="" (
    goto usageNonDatejjmmaaaa
    )
if "%annee%"=="" (
    goto usageNonDatejjmmaaaa
    )

:: On v‚rifie que %jour%, %mois%, %annee% sont bien des entiers. Si on d‚tecte un flotant, ou un caractŠre, ‡a va … l'‚tiquette usageArgCaractere. Voir http://stackoverflow.com/questions/684301/batch-file-input-validation-make-sure-user-entered-an-integer. 
:: Si %varTmp% n'est pas un entier, l'op‚ration attribue 0 … la variable %Evaluated%. Si %varTmp% est un flotant du type ®ÿ10.1ÿ¯, ou mˆme ®ÿ10.…ÿ¯, l'op‚ration attribue la valeur tronqu‚e de %varTmp%, provoque la lev‚e d'une exception non fatale ®ÿop‚rande manquanteÿ¯ (ici redirig‚e vers /Nul). Dans cet exemple-ci, vu que 10 non= 10.1, on va … l'‚tiquette usageArgCaractere. D'aprŠs mes recherches, batch ne supporte pas les op‚rations arithm‚tiques (d‚finies par /a) sur des flotants. Fonctionne avec les entiers n‚gatifs.
set varTmp=%jour%
  set /a Evaluated=%varTmp% 2> /NUL 
if not %Evaluated% EQU %varTmp% (
    goto usageArgCaractere
    )
  set varTmp=%mois%
  set /a Evaluated=%varTmp% 2> /NUL 
if not %Evaluated% EQU %varTmp% (
    goto usageArgCaractere
    )
  set varTmp=%annee%
  set /a Evaluated=%varTmp% 2> /NUL 
if not %Evaluated% EQU %varTmp% (
    goto usageArgCaractere
    )


  :: Permet de savoir si on a bien une ann‚e comprise entre 1583 et 2099 inclus.
if %annee% LSS 1583 (
    goto dateNonValide
    )
if %annee% GTR 2099 (
    goto dateNonValide
    )

  :: Permet de savoir si le mois est compris entre 1 et 12 inclus va … l'‚tiquette dateNonValide.
if %mois% LSS 1 (
    goto dateNonValide
    )
if %mois% GTR 12 (
    goto dateNonValide
    )

  :: Si le mois %mois% est inf‚rieur strict … 1, va a dateNonValide.
if %mois% LSS 1 (
    goto dateNonValide
    )

set /a moisModulo2=%mois%%%2
:: Si le mois %mois% ÿ4 ou 6 est sup‚rieur ou ‚gal … 31, va a l'‚tiquette dateNonValide.
if %mois% LEQ 7 (
    if %moisModulo2% EQU 0 (
      if not %mois% EQU 2 (
        if %jour% GEQ 31 (
          goto dateNonValide
          )
        )
      )
    )

:: Si le mois %mois%  1, 3, 5, ou 7 a un jour sup‚rieur strict … 31, va … l'‚tiquette dateNonValide.
if %mois% LEQ 7 (
    if not %moisModulo2% EQU 0 (
      if %jour% GTR 31 (
        goto dateNonValide
        )
      )
    )

:: Si le mois %mois% 8, 10 ou 12 a un jour sup‚rieur strict … 31, va … l'‚tiquette dateNonValide.
if %mois% GTR 7 (
    if %moisModulo2% EQU 0 (
      if %jour% GTR 31 (
        goto dateNonValide
        )
      )
    )

:: Si le mois %mois% 9 ou 11 a un jour sup‚rieur ou ‚gal … 31, va … l'‚tiquette dateNonValide.
if %mois% GTR 7 (
    if not %moisModulo2% EQU 0 (
      if %jour% GEQ 31 (
        goto dateNonValide
        )
      )
    )

:: On ne peut pas appeller nativement un programme dans un ® if ¯ en batch. ENCORE UNE BIZARERRIE DU BATCH. Si on l'appelle dans un si, on ne peut pas r‚cup‚rer la valeur de %estBissextile% g‚n‚r‚e par anneeBisextile.bat.
call anneeBissextile.bat %annee%  > /Nul 2> /Nul
:: On fait des v‚rification dans le cas o— on est dans le deuxiŠme mois d'une ann‚e du calendrier Gr‚gorien.
if %mois% EQU 2 (
  :: Rappel, si l'ann‚e est bissextile, le programme anneeBisextile.bat place 1 dans la variable %estBissextile%, sinon la variable %estBissextile% prend la valeur 0.  On ne se sert pas des sorties erreurs et standards, car on est d‚j… s–r que %annee% est une ann‚e valide.  Si l'ann‚e est bissextile, si le jour est sup‚rieur ou ‚gal … 29, va … l'‚tiquette dateNonValide. Sinon (donc si l'ann‚e n'est pas bissextile), si le jour est sup‚rieur ou ‚gal … 28, va … l'‚tiquette dateNonValideAnneNonBissextile.
  if %estBissextile% EQU 1 (
    if %jour% GTR 29 (
      goto dateNonValide
      )
    )
  ) 
:: Nouvelle bizarerie du batch, si on ‚crit ®ÿ) else (ÿ¯ … la place de la ligne ( ®ÿif %estBissextile% EQU 0ÿ¯ ), ‡a ne marche pas.
  if %estBissextile% EQU 0 (
    if %jour% GTR 28 (
      goto dateNonValideAnneNonBissextile
      )
    )

:: Si on n'a pas d‚t‚ct‚ que la date ‚tait non valide, alors ... la date est valide.
goto dateValide

:: IIø tiquettes de fin de programme
:: ------------------------------

:usageNbrArg 
echo            Vous devez entrer exactement un argument. 1>&2
goto finError

:usageNonDatejjmmaaaa
echo            Vous n'avez pas entr‚ une date sous la forme jj-mm-aaaa. 1>&2
goto finError

:dateNonValide
echo            La date que vous avez entr‚ est non valide. 1>&2
goto finError

:dateNonValideAnneNonBissextile
echo            La date que vous avez rentr‚ est non valide. Note, l'ann‚e n'est pas bissextile. 1>&2
goto finError

:dateValide
echo            La date que vous avez entr‚ est valide.
goto fin

:usage 
echo Ce programme permet de savoir si une date pass‚e en paramŠtres est valide. La date doit ˆtre entr‚e sous la forme j-m-aaaa ou jj-m-aaaa ou j-mm-aaaa ou jj-mm-aaaa. L'ann‚e doit ˆtre post‚rieure … 1582. Prend en compte le faite qu'une ann‚e soit bissextile ou non. Par exemple, dateValide 29-2-2015 retourne faux. 
echo Si l'argument n'est pas valable, affiche dans stderr un message d'erreur contextualis‚ et renvoie le code d'erreur ®ÿ6ÿ¯.
goto fin

:finError
echo. & echo. 
echo --------------------------------------------
echo. & echo. & echo.
exit /b 5

:fin
echo. & echo. 
echo --------------------------------------------
echo. & echo. & echo.
exit /b 0
