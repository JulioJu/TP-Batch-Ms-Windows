::                            -------------------
::                            |  DM de SystŠme  |
::                            |    Juanes852 |
::                            |      M1 DCISS   |
::                            |     07/11/2015  |
::                            -------------------


:: Ce programme calcule la variable d'environnement %CATEG% et afficha la cat‚gorie d'ƒge d'un athlŠte. Cette commande doit prendre en paramŠtre une ann‚e comprise entre 1905 et 2099, la cat‚gorie d'ƒge retourn‚e est une de celles de la f‚d‚ration fran‡aise d'athl‚tisme. Autour du r‚sultat affich‚, affiche ‚galement un header et un footer commenc‚s par le caractŠre ®ÿ-ÿ¯, ainsi que des lignes blanches.
:: Si l'argument n'est pas valable, affiche dans stderr un message d'erreur trŠs contextualis‚ et renvoie le code d'erreur ®ÿ3ÿ¯.

:: Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par Juanes852.
:: Test bon encodageÿ: ‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚
:: ATTENTION, ENCODAGE cp850, il permet d'afficher des accents dans la console Windows. Encodage non pris en charge par Notepad++, mais bien pris en charge par Vim. Sous Vim, taper ®ÿ: e ++enc=cp850ÿ¯ juste aprŠs l'ouverture du fichier. ENCODAGE GALEMENT PRIS EN CHARGE PAR MICROSOFT WORD, DTCT AUTOMATIQUEMENT · L'OUVERTURE DU FICHIER. En l'absence de Microsoft Word et, possibilit‚ de l'ouvrir avec le logiciel Dos ®ÿEditÿ¯ disponible sous Windows XP mais plus sous Windows Seven.
@echo off
echo. & echo. & echo.
echo ------------------ Categorie.bat ------------------
echo. & echo.

if "%1"=="/?" (
    goto usage
    )

:: Iø V‚rifications de la validit‚ du premier argument. Programation d‚fensive.
:: ----------------------------------------------------------
:: Existe-t-il bien un seul argumentÿ?
if not "%2"=="" (
    goto usageNbrArgIncorrect
    )
if "%1"=="" (
    goto usageNbrArgIncorrect
    )
:: Permet de tester si c'est un entier. Si c'est un flotant, ou un caractŠre, ‡a va … l'‚tiquette usageArgCaractere. Voir http://stackoverflow.com/questions/684301/batch-file-input-validation-make-sure-user-entered-an-integer, et mes explications compl‚mentaires dans le fichier ®ÿMaximum.batÿ¯.
set varTmp=%1
set /A Evaluated=%varTmp%
:: Si %varTmp% n'est pas un entier, l'op‚ration attribue 0 … la variable %Evaluated%. Si %varTmp% est un flottant du type ®ÿ10.1ÿ¯, ou mˆme ®ÿ10.…ÿ¯, l'op‚ration attribue la valeur tronqu‚e de %varTmp%, provoque la lev‚e d'une exception non fatale ®ÿop‚rande manquanteÿ¯ (ici redirig‚e vers /Nul). Dans cet exemple-ci, vu que 10 non= 10.1, on va … l'‚tiquette usageArgCaractere. D'aprŠs mes recherches, batch ne supporte pas les op‚rations arithm‚tiques (d‚finies par /a) sur des flotants. DFonctionne avec les entiers n‚gatifs.
if %Evaluated% EQU %varTmp% (
    echo Le nombre que vous avez entr‚ est bien un entier.
    ) else (
    goto usageArgCaractere
    )
if %1 GTR 2099 (
    goto usageArgInvalide
    )
if %1 LSS 1905 (
    goto usageArgInvalide
    )
:: Fin des tests sur les arguments
:: -------------------------------

:: IIø D‚but du test conditionnel. 
:: ---------------------------
:: Si %1 est sup‚rieur ou ‚gal … 2006, alors set CATEG=®ÿcole d'athl‚tismeÿ¯, et on va … la fin du test. Sinon la condition est fausse, et on va au test suivant, jusqu'… ce qu'on trouve une condition vraie. D'apŠs mes recherches, il n'existe pas de ®ÿsinon siÿ¯ en batch.
if %1 GEQ 2006 (
    set CATEG=®ÿcole d'athl‚tismeÿ¯
    goto finTestConditionnel 
    )
if %1 GEQ 2004 (
    set CATEG=®ÿPoussinsÿ¯
    goto finTestConditionnel 
    )
if %1 GEQ 2002 (
    set CATEG=®ÿBenjaminsÿ¯
    goto finTestConditionnel 
    )
if %1 GEQ 2000 (
    set CATEG=®ÿMinimesÿ¯
    goto finTestConditionnel
    )
if %1 GEQ 1998 (
    set CATEG=®ÿCadetsÿ¯
    goto finTestConditionnel
    )
if %1 GEQ 1996 (
    set CATEG=®ÿJuniorsÿ¯
    goto finTestConditionnel
    )
if %1 GEQ 1993 (
    set CATEG=®ÿEspoir ÿ¯
    goto finTestConditionnel
    )
if %1 GEQ 1976 (
    set CATEG=®ÿS‚niorsÿ¯
    goto finTestConditionnel
    ) else (
    set CATEG=®ÿMastersÿ¯
    goto finTestConditionnel
    )
:finTestConditionnel
:: Fin du test conditionnel 
:: ------------------------
:: Affichage du r‚sultatÿ: 
echo En athl‚tisme, les personnes n‚es en %1 appartiennent … la cat‚gorie %CATEG%.
goto fin
:: Fin du programme
:: ----------------

:: tiquettes de fin
:: -----------------

:usage
echo Ce programme calcule la variable d'environnement %CATEG% et affiche la cat‚gorie d'ƒge d'un athlŠte. Cette commande doit prendre en paramŠtre une ann‚e comprise entre 1905 et 2099, la cat‚gorie d'ƒge retourn‚e est une de celles de la f‚d‚ration fran‡aise d'athl‚tisme.
echo Si l'argument n'est pas valable, affiche dans stderr un message d'erreur trŠs contextualis‚ et renvoie le code d'erreur ®ÿ3ÿ¯.
echo Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par Juanes852.
goto fin

:usageNbrArgIncorrect
echo        Nombre d'arguments incorrects. Vous devez entrer en paramŠtre une seule et unique ann‚e. 1>&2
goto finError

:usageArgInvalide
echo        Argument invalide, l'ann‚e entr‚e n'est pas valide, elle doit ˆtre comprise entre 1905 et 2099. 1>&2
goto finError

:usageArgCaractere
echo        Argument invalide, vous n'avez pas entr‚ un nombre. 1>&2
goto finError

:finError
echo. & echo.
@echo ---------------------------------------------------
echo. & echo. & echo.
exit /b 3

:fin
echo. & echo.
@echo ---------------------------------------------------
echo. & echo. & echo.
exit /b 0
