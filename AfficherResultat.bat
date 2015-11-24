::                            -------------------
::                            |  DM de SystŠme  |
::                            |    juanes10 |
::                            |      M1 DCISS   |
::                            |     07/11/2015  |
::                            -------------------


:: Affiche la cat‚gorie et le meilleur lanc‚ d'un athlŠte de javelot donn‚. Par exemple, la commande ®ÿAfficherResultat Martin Galle 12-2-1991 94 87 93ÿ¯ a pour effet d'afficherÿ: ®ÿLe meilleur lanc‚ de Martin Galle, membre de la cat‚gorie des ®ÿS‚niorsÿ¯, est de 94 m.ÿ¯. Autour du r‚sultat, affiche ‚galement un header et un footer commenc‚s par le caractŠre ®ÿ-ÿ¯, ainsi que des lignes blanches.
:: Si le nombre d'arguments est invalide, renvoie un code d'erreur de ®ÿ2ÿ¯ si c'est .\Categorie.bat qui a ‚chou‚ renvoie ®ÿ3ÿ¯, si c'est .\Maximum.bat  qui ‚choue renvoie ®ÿ4ÿ¯, si c'est dateValide.bat qui ‚choue renvoie le code d'erreur 5. Dans tous les cas affiche un message d'erreur dans stderr trŠs contextualis‚.
:: Le deuxiŠme argument devra comporter entre six et dix caractŠres. Ainsi, ‚crire 2-2-1991 ne provoquera pas d'erreur.
:: Ce programme a ‚t‚ impl‚mant‚ pour que que les distances puissent ˆtre des flotants.

:: Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par juanes10.
:: Test bon encodageÿ: ‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚‚
:: ATTENTION, ENCODAGE cp850, il permet d'afficher des accents dans la console Windows. Encodage non pris en charge par Notepad++, mais bien pris en charge par Vim. Sous Vim, taper ®ÿ: e ++enc=cp850ÿ¯ juste aprŠs l'ouverture du fichier. ENCODAGE GALEMENT PRIS EN CHARGE PAR MICROSOFT WORD, DTCT AUTOMATIQUEMENT · L'OUVERTURE DU FICHIER. En l'absence de Microsoft Word et, possibilit‚ de l'ouvrir avec le logiciel Dos ®ÿEditÿ¯ disponible sous Windows XP mais plus sous Windows Seven.
@echo off
setlocal enabledelayedexpansion
echo. & echo. & echo.
echo ------------ AfficherResultat.bat ------------
echo. & echo.

::Permet d'afficher l'aide si le premier argument est "/?"
if "%1"=="/?" (
    goto usage 
    )

:: Iø Programmation d‚fensive. 
:: -------------------------------------------------------
if "%6"=="" (
    goto usageNbrArg
    )

:: V‚rifie si le deuxiŠme argument correspond … une date valable. Le jour doit ˆtre compris entre 1 et 31, ou entre 1 et 30, ou entre 1 et 29, ou entre 1 et 28 en fonction du mois (compris entre 1 et 12) et de l'ann‚e (comprise entre 1583 et 2099). Si on a entr‚ un flotant ou un caractŠre, plante. La date doit ˆtre de la forme jj-mm-aaaa.

call dateValide.bat %3 > /Nul 2> %tmp%\stderrATmp.tmp
set codeErreur=%ERRORLEVEL%
:: Si ® dateValide.batÿ¯ a ‚chou‚, alors on rentre dans la condition suivante, qui aboutiera … la sortie du programme.
if ERRORLEVEL 5 (
    echo    Erreur dans le troisiŠme argument, la commande ®ÿdateValide.bat %3ÿ¯ renvoie une erreur ®ÿ > %tmp%\stderrA.tmp 
    type    %tmp%\stderrATmp.tmp >> %tmp%\stderrA.tmp 
    del %tmp%\stderrATmp.tmp
    echo    ÿ¯>> %tmp%\stderrA.tmp
    goto finErrorCommandeInterne
    )

:: Partie prancipale du programe
::ÿ-----------------------------
::ÿ-----------------------------
::ÿ-----------------------------
::ÿ-----------------------------

:: Attribue successivement chaque argument … une variable nom‚e.
set nom=%1
shift 
:: Donc le deuxiŠme argument.
set prenom=%1
shift
:: Donc Le troisiŠme argument.
set annee=%1
:: Fonction substring, pour avoir les 4 derniers caractŠres du troisiŠme argument.
set annee=%annee:~-4%
:: Boucle qui concatŠne dans %moyenne% tous les arguments … partir du 4Šme.
shift
set moyennes=
:repeterMoyenne
if %1 LSS 0 (
    goto usageDistanceNegative
    )
set moyennes=%1 %moyennes%
shift
if not "%1"=="" (
    goto repeterMoyenne
    )


:: IIø G‚n‚ration des variables %CATEG%, puis %MAXI% grƒce … la commande ®ÿcallÿ¯. La sortie standard est envoy‚e dans /Nul, la sortie d'erreur est enregistr‚ dans %tmp%\stderrATmp.tmp et sera affich‚e retrait‚e.
:: ----------------
:: ----------------
:: 1ø Categorie.bat
:: ------------
:: ------
call Categorie.bat %annee% > /Nul 2> %tmp%\stderrATmp.tmp
:: Traitement du cas d'erreur de Categorie.bat.
:: ------
:: Categorie impl‚mente un cas d'erreur suppl‚menetaire par rapport … dateValide.bat, il permet de d‚tecter si la personne est n‚e aprŠs 1905, si elle a moins de 100 ans en 2015.
:: Permet de sauvegarder le code d'erreur renvoy‚ par ®ÿCategorie.batÿ¯. En cas o— la comande Categorie.bat ‚choue, ce code sera imprim‚, et ®ÿAfficherResultat.batÿ¯ terminera avec ce code d'erreur-ci.
set codeErreur=%ERRORLEVEL%
:: Si ® Categorie.batÿ¯ a ‚chou‚, alors on rentre dans la condition suivante, qui aboutiera … la sortie du programme.
if ERRORLEVEL 3 (
    echo    Erreur dans le troisiŠme argument, la commande ®ÿCategorie.bat %annee%ÿ¯ renvoie une erreur ®ÿ > %tmp%\stderrA.tmp 
    type    %tmp%\stderrATmp.tmp >> %tmp%\stderrA.tmp 
    del %tmp%\stderrATmp.tmp
    echo    ÿ¯>> %tmp%\stderrA.tmp
    goto finErrorCommandeInterne
    )
:: 2ø Maximum.bat
:: ------------
:: ------
call Maximum.bat %moyennes% > /Nul 2> %tmp%\stderrATmp.tmp
:: Traitement du cas d'erreur de Maximum.bat
:: -------
:: Permet de sauvegarder le code d'erreur renvoy‚ par ®ÿMaximum.batÿ¯. En cas o— la comande Maximum.bat ‚choue, ce code sera imprim‚, et ®ÿAfficherResultat.batÿ¯ terminera avec ce code d'erreur-ci.
set codeErreur=%ERRORLEVEL%
:: Si ® Maximum.batÿ¯ a ‚chou‚, alors on rentre dans la condition suivante, qui aboutiera … la sortie du programme.
if ERRORLEVEL 4 (
    echo    Erreur situ‚e … partir du quatriŠme argument. La commande ®ÿMaximum.bat %moyennes%ÿ¯ renvoie une erreurÿ: ®ÿ > %tmp%\stderrA.tmp 
    type %tmp%\stderrATmp.tmp >> %tmp%\stderrA.tmp 
    del %tmp%\stderrATmp.tmp
    echo    ÿ¯. >> %tmp%\stderrA.tmp
    goto finErrorCommandeInterne
    )
:: Traitement du cas de r‚uissite.  Affichageÿ:
:: -----
:: -----
echo Le meilleur lanc‚ de %nom% %prenom%, membre de la cat‚gorie des %CATEG%, est de %MAXI% m.

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
:: Fin du programme principal.
:: ---------------------------
:: ---------------------------
:: ---------------------------


:: IIIø tiquettes de fin
::ÿ------------------

:usage
echo Affiche la cat‚gorie et le meilleur lanc‚ d'un athlŠte de javelot donn‚. Par exemple, la commande ®ÿAfficherResultat Martin Galle 12-2-1991 94 87 93ÿ¯ a pour effet d'afficherÿ: ®ÿLe meilleur lanc‚ de Martin Galle, membre de la cat‚gorie des ®ÿS‚niorsÿ¯, est de 94 m.ÿ¯.
echo Si le nombre d'arguments est invalide, renvoie un code d'erreur de ®ÿ2ÿ¯ si c'est .\Categorie.bat qui a ‚chou‚ renvoie ®ÿ3ÿ¯, si c'est .\Maximum.bat  qui ‚choue renvoie ®ÿ4ÿ¯, si c'est dateValide.bat qui ‚choue renvoie le code d'erreur 5. Dans tous les cas affiche un message d'erreur dans stderr trŠs contextualis‚.
echo Le deuxiŠme argument devra comporter entre six et dix caractŠres. Ainsi, ‚crire 2-2-1991 ou 02-02-1991 ne provoqueront pas d'erreur.
echo Le programme a ‚t‚ impl‚mant‚ pour supporter les nombres flotant.
echo Test‚ et d‚velopp‚ sous Windows XP SP3 ‚dition familiale en 2015 par juanes10.


:usageNbrArg 
echo    Vous devez entrer 6 agruments. 1>&2
goto finError

:usageDistanceNegative
echo    Vous avez entr‚ une distance n‚gative, %1 n'est pas valable. 1>&2
goto finError

:finError
echo. & echo.
echo ----------------------------------------------
echo. & echo. & echo.
exit /b 2

:finErrorCommandeInterne 
:: Le message d'erreurs en partie g‚n‚r‚ par un des sous programmes et ‚cris dans %tmp%\stderrATmp.tmp est redirig‚ vers la sortie d'erreur.
type %tmp%\stderrA.tmp 1>&2
del %tmp%\stderrA.tmp
:: %codeErreur% a pour valeur le code d'erreur du sous-programme qui a plant‚.
echo    Code de l'erreur %codeErreur%.
echo. & echo.
echo ----------------------------------------------
echo. & echo. & echo.
exit /b %codeErreur%

:fin
echo. & echo.
echo ----------------------------------------------
echo. & echo. & echo.
exit /b 0
