::                            -------------------
::                            |  DM de SystŠme  |
::                            |    juanes10 |
::                            |      M1 DCISS   |
::                            |     07/11/2015  |
::                            -------------------


:: Ce programme concerne la gestion d'une ‚preuve de lanc‚ de Javelot. Durant cette comp‚tition, chaque athlŠte a eu 3 essais.
:: Affiche, pour chaque athlŠte du fichier pass‚ en paramŠtre, sa cat‚gorie d'ƒge et son meilleur lanc‚. 
:: Le fichier pass‚ en paramŠtre doit ˆtre format‚ de la maniŠre suivanteÿ:  
:: #Fichiers des athletes [commentaire non pris en compte]
:: Galle:Martin:12-2-1991:94:87:100
:: Honnete:Marie:4-12-1950:98:100:10
:: Ce programme a ‚t‚ impl‚mant‚ pour que que les distances puissent ˆtre des flotants, avec v‚rification de la validit‚ du flotant.

:: Autour du r‚sultat, affiche ‚galement un header et un footer commenc‚s par le caractŠre ®ÿ-ÿ¯, ainsi que des lignes blanches.
:: Si le fichier n'existe pas, renvoie ®ÿ1ÿ¯ comme code d'erreur. Si ./AfficherResultat.bat a ‚chou‚, renvoie ®ÿ2ÿ¯, ./Categorie.bat renvoie ®ÿ3ÿ¯, ./Maximum.bata renvoie ®ÿ4ÿ¯ et dateValide.bat renvoie ®ÿ5ÿ¯ et affiche un message d'erreur dans stderr trŠs contextualis‚.

:: On a pu constater qu'on ne pouvait pas r‚cup‚rer la variable %MAXI%, la comande ®ÿecho %MAXI% ¯ ne renvoie rien. Dans les sous-programmes on a r‚solu le problŠme grƒce … http://stackoverflow.com/questions/3262287/make-an-environment-variable-survive-endlocal, mais il n'est pas n‚cessaire de proc‚der ainsi dans ce programme, les valeurs %MAXI% et %CATEG% n'ont aucun int‚rˆt d'ˆtre conserv‚es aprŠs la fin du programme.


:: Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par juanes10.
:: Test bon encodageÿ: ‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚
:: ATTENTION, ENCODAGE cp850, il permet d'afficher des accents dans la console Windows. Encodage non pris en charge par Notepad++, mais bien pris en charge par Vim. Sous Vim, taper ®ÿ: e ++enc=cp850ÿ¯ juste aprŠs l'ouverture du fichier. ENCODAGE GALEMENT PRIS EN CHARGE PAR MICROSOFT WORD, DTCT AUTOMATIQUEMENT · L'OUVERTURE DU FICHIER. En l'absence de Microsoft Word et, possibilit‚ de l'ouvrir avec le logiciel Dos ®ÿEditÿ¯ disponible sous Windows XP mais plus sous Windows Seven.

@echo off
echo. & echo. & echo.
echo ------------ CalculerResultat.bat -----------
echo. & echo.
setlocal enabledelayedexpansion

::Permet d'afficher l'aide si le premier argument est "/?"
if "%1"=="/?" (
    goto usage 
    )

:: Iø Programmation d‚fensive. 
:: ------------------------
:: Permet d'afficher un message d'erreur si on n'a pas entr‚ assez ou trop d'arguments.
if "%1"=="" (
    goto usageNbrArg 
    )
if not "%2"=="" (
    goto usageNbrArg
    )
:: Permet d'afficher un message d'erreur si on n'a pas entr‚ en pramŠtre un nom de fichier.
dir /ad %1 > /NUL 2> /NUL
if not ERRORLEVEL 1 (
    goto usageArgNomFichier
    )

:: IIø D‚but de la partie principale du programme.
:: ------------------------------------------
:: ------------------------------------------
:: ------------------------------------------

:: Voir aussi http://ss64.com/nt/for_f.html.

:: Fichier de sortie normale. D'aprŠs mes recherches, on ne peut pas rediriger la sortie d'une commande vers une variable. Voir http://stackoverflow.com/questions/6359820/batch-files-how-to-set-commands-output-as-a-variable. On est oblig‚ de passer par un fichier.
del %tmp%\stdoutC.tmp 2> /Nul
:: Boucle for qui permet de supprimer toutes les lignes commen‡ant par ®ÿ#ÿ¯ dans le fichier pass‚ en paramŠtre.
for /f "eol=#" %%a in (%1) do (
    :: !ligneTraitee! prend successivement la valeur de toutes les lignes de %1, sauf les lignes de commentaires.
    set ligneTraitee=%%a
    :: G‚n‚ration d'un fichier contenant la sortie de la commande ®ÿAfficherResultatÿ¯. Ce fichier contient des lignes commen‡ant par le caractŠre ®ÿ-ÿ¯, et des lignes vides.  Grƒce … la direcive ®ÿsetlocal enabledelayedexpansionÿ¯ situ‚e plus haut, on peut utiliser la variable !ligneTraitee! qui permet d'‚valuer la variable !ligneTraitee! non au moment de l'analyse, mais au moment de l'ex‚cution. ®ÿ%ligneTraitee%ÿ¯ prendait la valeur du premier bouclage, et resterait fix‚e sur cette valeur. La commande %variableNommee:;= % permet de remplacer tous les caractŠres ®ÿ;ÿ¯ par des espaces dans la variable %variableNommee%. La sortie normal est redirig‚e vers %tmp%\stdoutC.tmp, ce fichier sera trait‚ pour supprimer toutes les lignes non d‚sir‚es. La sortie d'erreur est redirig‚e vers stderrCTmp.tmp, le message d'erreur sera inclus dans un autre message d'erreur plus complet. Note, ce commentaire est un peu long, mais il est impossible d'utiliser deux comentaires ®ÿ::ÿ¯ … la suite dans une boucle en Batch (et j'ai mis du temps … trover pourquoi ‡a plantait). J'ai tent‚ de remplacer tous les ®ÿ::ÿ¯ par des ®ÿREMÿ¯, et l… mon programme a explos‚, il a fait un echo des commentaires. J'imagine que batch est un des seuls langage de programmation o— quand on ajoute des commentaires, ‡a fait planter le programme.
    call AfficherResultat.bat !ligneTraitee::= ! >> %tmp%\stdoutC.tmp 2> %tmp%\stderrCTmp.tmp
    :: Traitement des cas d'erreur ---------- Permet de sauvegarder le code d'erreur renvoy‚ par ®ÿAfficherResultat.batÿ¯. En cas o— la comande AfficherResultat.bat ‚choue, ce code sera imprim‚, et ®ÿCalculerResultat.batÿ¯ terminera avec ce code d'erreur-ci.
    set codeErAff=!ERRORLEVEL! 
    :: Si ® AfficherResultat.batÿ¯ a ‚chou‚, alors on rentre dans la condition suivante, qui aboutiera … la sortie du programme.
    if ERRORLEVEL 2 (
      echo Le fichier %1 est non valide … la ligne contenant ®ÿ!ligneTraitee!ÿ¯. Pr‚cision renvoy‚e par la commande AfficherResultat.batÿ: ®ÿ> %tmp%\stderrC.tmp
      type %tmp%\stderrCTmp.tmp >> %tmp%\stderrC.tmp
      del %tmp%\stderrCTmp.tmp
      echo ¯. >> %tmp%\stderrC.tmp

      :: Recherche du num‚ro de la ligne grƒce … la commande findstr. Cette commande sort par exemple ®ÿ11:Marie...ÿ¯, avec ®ÿ11ÿ¯ le num‚ro de ligne.  On est oblig‚ de regiriger dans un fichier, r‚sultat de findstr ne peut pas ˆtre mis dans une variable. Encore une Bizarerie du batch.
      findstr /n "!ligneTraitee!" %1  > %tmp%\CalculerResultatNumLigneError.tmp
      for /f "tokens=1 delims=:" %%c in (%tmp%\CalculerResultatNumLigneError.tmp) do (
        set numeroLigneExacte=%%c
        echo Le num‚ro de ligne de l'erreur estÿ: !numeroLigneExacte!. >> %tmp%\stderrC.tmp
      )

    goto finErrorCommandeInterne
    )
)

:: Traitement du cas de r‚ussite
:: ----
:: Boucle for qui permet de supprimer toutes les lignes commen‡ant par le caractŠre ®ÿ-ÿ¯.
for /f "eol=- tokens=*" %%k in (%tmp%\stdoutC.tmp) do (
:: Si la ligne n'est pas vide, affichage de la ligne.
if not "%%k"=="" echo %%k 
)
:: Supprime le fichier stdoutC.tmp.
del %tmp%\stdoutC.tmp 2> /Nul

:: http://stackoverflow.com/questions/3262287/make-an-environment-variable-survive-endlocal
:: A FOR expression is an excellent choice to transport a value across the ENDLOCAL barrier if you are concerned about special characters. Delayed expansion should be enabled before the ENDLOCAL, and disabled after the ENDLOCAL.
for /f "delims=" %%A in ("!CATEG!") do (
    for /f "delims=" %%B in ("!MAXI!") do (
      endlocal
      set CATEG=%%~A
      set MAXI=%%~B
      )
    )

goto fin
:: Fin du Programme
:: ----------------

:: IIIø tiquettes de fin de programme
:: ------------------------------

:usageArgNomFichier
echo Le paramŠtre que vous avez entr‚ ne correspond pas … un nom de fichier valide. 1>&2
goto finError

:usageNbrArg 
echo Vous devez entrer un argument, il doit correspondre … nom de fichier. 1>&2
goto finError

:usage 
echo Ce programme concerne la gestion d'une ‚preuve de lanc‚ de Javelot. Durant cette comp‚tition, chaque athlŠte a eu 3 essais.
echo Un fichier doit ˆtre pass‚ en paramŠtre, chaque ligne du fichier correspond … un athlŠte avec son nom, puis son pr‚nom, puis sa date de naissance, puis ses scores de lanc‚.  Le programme affiche pour chaque atthlŠte sa cat‚gorie (calcul‚e en fonction de l'ann‚e), et son mailleur lanc‚.
echo Le fichier pass‚ en paramŠtre doit ˆtre format‚ de la maniŠre suivanteÿ:  
echo #Fichiers des athletes [commentaire non pris en compte]
echo Galle:Martin:12-2-1991:94:87:100 
echo Honnete:Marie:4-12-1950:98:100:10
echo Les distances peuvent ˆtre des flotants.
echo Si le fichier n'existe pas, renvoie ®ÿ1ÿ¯ comme code d'erreur. Si ./AfficherResultat.bat a ‚chou‚, renvoie ®ÿ2ÿ¯, ./Categorie.bat renvoie ®ÿ3ÿ¯, ./Maximum.bata renvoie ®ÿ4ÿ¯ et dateValide.bat renvoie ®ÿ5ÿ¯ et affiche un message d'erreur dans stderr trŠs contextualis‚.
echo Ce programme a ‚t‚ impl‚mant‚ pour que que les distances puissent ˆtre des flotants.
echo Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par juanes10.
goto fin 

:finError
echo. & echo.
echo ---------------------------------------------
echo. & echo. & echo.
exit /b 1

:finErrorCommandeInterne 
:: Le message d'erreurs en partie g‚n‚r‚ par un des sous programmes et ‚cris dans %tmp%\stderrC.tmp est redirig‚ vers la sortie d'erreur.
type %tmp%\stderrC.tmp 1>&2
del %tmp%\stderrC.tmp
:: %codeErAff% a pour valeur le code d'erreur du sous-programme qui a plant‚.
echo Code de l'erreur %codeErAff%.
echo. & echo.
echo ----------------------------------------------
echo. & echo. & echo.
exit /b %codeErAff%

:fin
echo. & echo.
echo ---------------------------------------------
echo. & echo. & echo.
exit /b 0
