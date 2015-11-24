::                            -------------------
::                            |  DM de SystŠme  |
::                            |    Juanes852 |
::                            |      M1 DCISS   |
::                            |     07/11/2015  |
::                            -------------------


:: Ce programme permet de savoir si une ann‚e entr‚e en paramŠtre est bissextile. Rappel, une ann‚e est bissextile si elle est divisible par 400, ou si elle est divisible par 4 mais pas par 100, et ce depuis 1582. Autour du r‚sultat, affiche ‚galement un header et un footer commenc‚s par le caractŠre ®ÿ-ÿ¯, ainsi que des lignes blanches. Si l'ann‚e est bissextile, %estBissextile%=1, sinon %estBissextile%==0.
:: Si l'argument n'est pas valable, affiche dans stderr un message d'erreur contextualis‚ et renvoie le code d'erreur ®ÿ6ÿ¯.

:: Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par Juanes852.
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
    echo truc
    goto usageNbrArg 
    )
if not "%2"=="" (
    echo truc
    goto usageNbrArg
    )

:: Si l'ann‚e est inf‚rieure … 1582, renvoie un message d'erreur.
if %1 LSS 1582 (
    goto usageAnneeInvalide
    )
:: Programmation d‚fensive. On v‚rifie que %1 est bien un entier. Si c'est un flotant, ou un caractŠre, ‡a va … l'‚tiquette usageArgCaractere. Voir http://stackoverflow.com/questions/684301/batch-file-input-validation-make-sure-user-entered-an-integer. 
:: Si %varTmp% n'est pas un entier, l'op‚ration attribue 0 … la variable %Evaluated%. Si %varTmp% est un flottant du type ®ÿ10.1ÿ¯, ou mˆme ®ÿ10.…ÿ¯, l'op‚ration attribue la valeur tronqu‚e de %varTmp%, provoque la lev‚e d'une exception non fatale ®ÿo‚rande manquanteÿ¯ (ici redirig‚e vers /Nul). Dans cet exemple-ci, vu que 10 non= 10.1, on va … l'‚tiquette usageArgCaractere. D'aprŠs mes recherches, batch ne supporte pas les op‚rations arithm‚tiques (d‚finies par /a) sur des flotants. Fonctionne avec les entiers n‚gatifs.
set varTmp=%1
set /a Evaluated=%varTmp% 2> /NUL 
if not %Evaluated% EQU %varTmp% (
    goto usageArgCaractere
    )
:: Fin de la programmation d‚fensive.

:: IIø D‚but de la partie principale du programme.
:: ------------------------------------------
:: ------------------------------------------

:: Rappel, une ann‚e est bissextile si elle est divisible par 400, ou si elle est divisible par 4 mais pas par 100. Dans tous les autres cas, l'ann‚e n'est pas bissextile.

set /a modulo100=%1%%100
set /a modulo400=%1%%400
set /a modulo4=%1%%4

if %modulo400% EQU 0 (
    goto estBissextile
)

if %modulo100% EQU 0 (
    goto nEstPasBissextile
    )
)

if %modulo4% EQU 0 (
    goto estBissextile
)

goto nEstPasBissextile

:: IIø tiquettes de fin de programme
:: ------------------------------

:usageNbrArg 
echo            Vous devez entrer exactement un entier. 1>&2
goto finError

:usageAnneeInvalide
echo            Les ann‚es bissextiles ont ‚t‚ introduites par le calendrier Gr‚gorien, il commence en 1582 dans les tats reconnaissant l'autorit‚ papale, vous ne pouvez pas rentrer une ann‚e ant‚rieure … 1582. 1>&2
goto finError

:usageArgCaractere
echo            Argument invalide, vous n'avez pas entr‚ uniquement des nombres. Vous ne pouvez entrer qu'une suite de nombres. 1>&2
goto finError

:usage 
echo Ce programme permet de savoir si une ann‚e entr‚e en paramŠtres est bissextile. Rappel, une ann‚e est bissextile si elle est divisible par 400, ou si elle est divisible par 4 mais pas par 100, et ce depuis 1582. Si l'ann‚e est bissextile, %estBissextile%=1, sinon %estBissextile%==0.
echo Si l'argument n'est pas valable, affiche dans stderr un message d'erreur contextualis‚ et renvoie le code d'erreur ®ÿ6ÿ¯.
echo Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par Juanes852.
goto fin

:nEstPasBissextile 
echo %1 n'est pas bissextile.
set estBissextile=0
goto fin

:estBissextile
echo %1 est une ann‚e bissextile.
set estBissextile=1
goto fin

:finError
echo. & echo. 
echo --------------------------------------------
echo. & echo. & echo.
exit /b 6

:fin
echo. & echo. 
echo --------------------------------------------
echo. & echo. & echo.
exit /b 0
