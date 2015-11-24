::                            -------------------
::                            |  DM de Syst�me  |
::                            |    juanes10 |
::                            |      M1 DCISS   |
::                            |     07/11/2015  |
::                            -------------------


:: Ce programme concerne la gestion d'une �preuve de lanc� de Javelot. Durant cette comp�tition, chaque athl�te a eu 3 essais.
:: Affiche, pour chaque athl�te du fichier pass� en param�tre, sa cat�gorie d'�ge et son meilleur lanc�. 
:: Le fichier pass� en param�tre doit �tre format� de la mani�re suivante�:  
:: #Fichiers des athletes [commentaire non pris en compte]
:: Galle:Martin:12-2-1991:94:87:100
:: Honnete:Marie:4-12-1950:98:100:10
:: Ce programme a �t� impl�mant� pour que que les distances puissent �tre des flotants, avec v�rification de la validit� du flotant.

:: Autour du r�sultat, affiche �galement un header et un footer commenc�s par le caract�re ��-��, ainsi que des lignes blanches.
:: Si le fichier n'existe pas, renvoie ��1�� comme code d'erreur. Si ./AfficherResultat.bat a �chou�, renvoie ��2��, ./Categorie.bat renvoie ��3��, ./Maximum.bata renvoie ��4�� et dateValide.bat renvoie ��5�� et affiche un message d'erreur dans stderr tr�s contextualis�.

:: On a pu constater qu'on ne pouvait pas r�cup�rer la variable %MAXI%, la comande ��echo %MAXI% � ne renvoie rien. Dans les sous-programmes on a r�solu le probl�me gr�ce � http://stackoverflow.com/questions/3262287/make-an-environment-variable-survive-endlocal, mais il n'est pas n�cessaire de proc�der ainsi dans ce programme, les valeurs %MAXI% et %CATEG% n'ont aucun int�r�t d'�tre conserv�es apr�s la fin du programme.


:: Test� et d�velopp� sous Windows XP SP3 �dition familiale en 2015 par juanes10.
:: Test bon encodage�: ������������������
:: ATTENTION, ENCODAGE cp850, il permet d'afficher des accents dans la console Windows. Encodage non pris en charge par Notepad++, mais bien pris en charge par Vim. Sous Vim, taper ��: e ++enc=cp850�� juste apr�s l'ouverture du fichier. ENCODAGE �GALEMENT PRIS EN CHARGE PAR MICROSOFT WORD, D�T�CT� AUTOMATIQUEMENT � L'OUVERTURE DU FICHIER. En l'absence de Microsoft Word et, possibilit� de l'ouvrir avec le logiciel Dos ��Edit�� disponible sous Windows XP mais plus sous Windows Seven.

@echo off
echo. & echo. & echo.
echo ------------ CalculerResultat.bat -----------
echo. & echo.
setlocal enabledelayedexpansion

::Permet d'afficher l'aide si le premier argument est "/?"
if "%1"=="/?" (
    goto usage 
    )

:: I� Programmation d�fensive. 
:: ------------------------
:: Permet d'afficher un message d'erreur si on n'a pas entr� assez ou trop d'arguments.
if "%1"=="" (
    goto usageNbrArg 
    )
if not "%2"=="" (
    goto usageNbrArg
    )
:: Permet d'afficher un message d'erreur si on n'a pas entr� en pram�tre un nom de fichier.
dir /ad %1 > /NUL 2> /NUL
if not ERRORLEVEL 1 (
    goto usageArgNomFichier
    )

:: II� D�but de la partie principale du programme.
:: ------------------------------------------
:: ------------------------------------------
:: ------------------------------------------

:: Voir aussi http://ss64.com/nt/for_f.html.

:: Fichier de sortie normale. D'apr�s mes recherches, on ne peut pas rediriger la sortie d'une commande vers une variable. Voir http://stackoverflow.com/questions/6359820/batch-files-how-to-set-commands-output-as-a-variable. On est oblig� de passer par un fichier.
del %tmp%\stdoutC.tmp 2> /Nul
:: Boucle for qui permet de supprimer toutes les lignes commen�ant par ��#�� dans le fichier pass� en param�tre.
for /f "eol=#" %%a in (%1) do (
    :: !ligneTraitee! prend successivement la valeur de toutes les lignes de %1, sauf les lignes de commentaires.
    set ligneTraitee=%%a
    :: G�n�ration d'un fichier contenant la sortie de la commande ��AfficherResultat��. Ce fichier contient des lignes commen�ant par le caract�re ��-��, et des lignes vides.  Gr�ce � la direcive ��setlocal enabledelayedexpansion�� situ�e plus haut, on peut utiliser la variable !ligneTraitee! qui permet d'�valuer la variable !ligneTraitee! non au moment de l'analyse, mais au moment de l'ex�cution. ��%ligneTraitee%�� prendait la valeur du premier bouclage, et resterait fix�e sur cette valeur. La commande %variableNommee:;= % permet de remplacer tous les caract�res ��;�� par des espaces dans la variable %variableNommee%. La sortie normal est redirig�e vers %tmp%\stdoutC.tmp, ce fichier sera trait� pour supprimer toutes les lignes non d�sir�es. La sortie d'erreur est redirig�e vers stderrCTmp.tmp, le message d'erreur sera inclus dans un autre message d'erreur plus complet. Note, ce commentaire est un peu long, mais il est impossible d'utiliser deux comentaires ��::�� � la suite dans une boucle en Batch (et j'ai mis du temps � trover pourquoi �a plantait). J'ai tent� de remplacer tous les ��::�� par des ��REM��, et l� mon programme a explos�, il a fait un echo des commentaires. J'imagine que batch est un des seuls langage de programmation o� quand on ajoute des commentaires, �a fait planter le programme.
    call AfficherResultat.bat !ligneTraitee::= ! >> %tmp%\stdoutC.tmp 2> %tmp%\stderrCTmp.tmp
    :: Traitement des cas d'erreur ---------- Permet de sauvegarder le code d'erreur renvoy� par ��AfficherResultat.bat��. En cas o� la comande AfficherResultat.bat �choue, ce code sera imprim�, et ��CalculerResultat.bat�� terminera avec ce code d'erreur-ci.
    set codeErAff=!ERRORLEVEL! 
    :: Si � AfficherResultat.bat�� a �chou�, alors on rentre dans la condition suivante, qui aboutiera � la sortie du programme.
    if ERRORLEVEL 2 (
      echo Le fichier %1 est non valide � la ligne contenant ��!ligneTraitee!��. Pr�cision renvoy�e par la commande AfficherResultat.bat�: ��> %tmp%\stderrC.tmp
      type %tmp%\stderrCTmp.tmp >> %tmp%\stderrC.tmp
      del %tmp%\stderrCTmp.tmp
      echo �. >> %tmp%\stderrC.tmp

      :: Recherche du num�ro de la ligne gr�ce � la commande findstr. Cette commande sort par exemple ��11:Marie...��, avec ��11�� le num�ro de ligne.  On est oblig� de regiriger dans un fichier, r�sultat de findstr ne peut pas �tre mis dans une variable. Encore une Bizarerie du batch.
      findstr /n "!ligneTraitee!" %1  > %tmp%\CalculerResultatNumLigneError.tmp
      for /f "tokens=1 delims=:" %%c in (%tmp%\CalculerResultatNumLigneError.tmp) do (
        set numeroLigneExacte=%%c
        echo Le num�ro de ligne de l'erreur est�: !numeroLigneExacte!. >> %tmp%\stderrC.tmp
      )

    goto finErrorCommandeInterne
    )
)

:: Traitement du cas de r�ussite
:: ----
:: Boucle for qui permet de supprimer toutes les lignes commen�ant par le caract�re ��-��.
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

:: III� �tiquettes de fin de programme
:: ------------------------------

:usageArgNomFichier
echo Le param�tre que vous avez entr� ne correspond pas � un nom de fichier valide. 1>&2
goto finError

:usageNbrArg 
echo Vous devez entrer un argument, il doit correspondre � nom de fichier. 1>&2
goto finError

:usage 
echo Ce programme concerne la gestion d'une �preuve de lanc� de Javelot. Durant cette comp�tition, chaque athl�te a eu 3 essais.
echo Un fichier doit �tre pass� en param�tre, chaque ligne du fichier correspond � un athl�te avec son nom, puis son pr�nom, puis sa date de naissance, puis ses scores de lanc�.  Le programme affiche pour chaque atthl�te sa cat�gorie (calcul�e en fonction de l'ann�e), et son mailleur lanc�.
echo Le fichier pass� en param�tre doit �tre format� de la mani�re suivante�:  
echo #Fichiers des athletes [commentaire non pris en compte]
echo Galle:Martin:12-2-1991:94:87:100 
echo Honnete:Marie:4-12-1950:98:100:10
echo Les distances peuvent �tre des flotants.
echo Si le fichier n'existe pas, renvoie ��1�� comme code d'erreur. Si ./AfficherResultat.bat a �chou�, renvoie ��2��, ./Categorie.bat renvoie ��3��, ./Maximum.bata renvoie ��4�� et dateValide.bat renvoie ��5�� et affiche un message d'erreur dans stderr tr�s contextualis�.
echo Ce programme a �t� impl�mant� pour que que les distances puissent �tre des flotants.
echo Test� et d�velopp� sous Windows XP SP3 �dition familiale en 2015 par juanes10.
goto fin 

:finError
echo. & echo.
echo ---------------------------------------------
echo. & echo. & echo.
exit /b 1

:finErrorCommandeInterne 
:: Le message d'erreurs en partie g�n�r� par un des sous programmes et �cris dans %tmp%\stderrC.tmp est redirig� vers la sortie d'erreur.
type %tmp%\stderrC.tmp 1>&2
del %tmp%\stderrC.tmp
:: %codeErAff% a pour valeur le code d'erreur du sous-programme qui a plant�.
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
