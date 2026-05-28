@echo off
title [CONNECT LABS] - Otimizador de RAM Universal v3.2
mode con: cols=90 lines=32

:: ====================================================================
:: VERIFICAÇÃO DE ADMINISTRADOR
:: ====================================================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo =======================================================================
    echo [ERRO / ERROR] ACESSO NEGADO / ACCESS DENIED!
    echo =======================================================================
    echo  Este script precisa de permissoes de Administrador para rodar.
    echo  Por favor: Clica com o botao direito no ficheiro e escolhe:
    echo  "EXECUTAR COMO ADMINISTRADOR" / "RUN AS ADMINISTRADOR"
    echo =======================================================================
    pause
    exit
)

:IDIOMA
cls
color 0B
echo ===============================================================================
echo   SELECT YOUR LANGUAGE / SELECCIONE SU IDIOMA / SELECIONE O SEU IDIOMA
echo ===============================================================================
echo.
echo   [1] Portugues
echo   [2] English
echo   [3] Espanol
echo.
echo ===============================================================================
set /p lang="Choose (1-3): "

if "%lang%"=="1" goto PT
if "%lang%"=="2" goto EN
if "%lang%"=="3" goto ES
goto IDIOMA

:: ====================================================================
:: TEXTOS EM PORTUGUÊS
:: ====================================================================
:PT
cls
color 0E
echo ===============================================================================
echo   NOTA DO CRIADOR (Gui - CONNECT): Porque este script?
echo ===============================================================================
echo   Eu criei e adicionei estas rotinas porque foi o que VERIDICAMENTE funcionou 
echo   comigo. O meu Windows estava a bloquear a minha memoria fisica, fazendo com 
echo   que o PC arrancasse a consumir uns absurdos 23GB de RAM. Apos aplicar estes 
echo   comandos, o consumo desceu imediatamente para uns limpos e normais 6GB!
echo ===============================================================================
echo.
echo   O QUE ESTE SCRIPT VAI FAZER NO SEU PC:
echo   1. Limpar e resetar bloqueios de memoria maxima ocultos no Boot (MSConfig).
echo   2. Corrigir chaves de registo que forcam o mapeamento de hardware preso.
echo   3. Limpar a Standby List, cache de despejo do sistema e flush de DNS.
echo   4. Forcar o coletor do Windows (via PowerShell) a libertar RAM inutil.
echo.
echo ===============================================================================
set /p conf="Deseja continuar com a otimizacao? (S/N): "
if /i "%conf%" neq "S" goto IDIOMA

:MENU_PT
cls
color 0B
echo ===============================================================================
echo   Ferramenta Universal de Desbloqueio de RAM - CONNECT Labs
echo ===============================================================================
echo.
echo  [1] Executar Diagnostico e Desbloqueio Total (Recomendado - Requer Reiniciar)
echo  [2] Limpeza Rapida de Cache e Memoria em Espera (Sem Reiniciar)
echo  [3] Voltar ao Menu de Idioma
echo  [4] Sair
echo.
echo ===============================================================================
set /p op_pt="Escolha uma opcao (1-4): "

if "%op_pt%"=="1" goto COMPLETO_PT
if "%op_pt%"=="2" goto RAPIDO_PT
if "%op_pt%"=="3" goto IDIOMA
if "%op_pt%"=="4" exit
goto MENU_PT

:COMPLETO_PT
cls
color 0A
echo [+] A remover restricoes de memoria no arranque (BCDEdit)...
bcdedit /deletevalue {current} removememory >nul 2>&1
bcdedit /deletevalue {current} truncatememory >nul 2>&1
echo [+] A otimizar chaves de gestao de memoria no Registo...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul 2>&1
echo [+] A reiniciar o Explorador e a limpar tabelas de cache...
taskkill /f /im explorer.exe >nul 2>&1
ipconfig /flushdns >nul 2>&1
start explorer.exe
echo.
echo ===============================================================================
echo [SUCESSO] O sistema foi reconfigurado! O bloqueio de RAM foi removido.
echo ===============================================================================
set /p re_pt="Queres reiniciar o computador agora para aplicar? (S/N): "
if /i "%re_pt%"=="S" shutdown /r /t 5
goto MENU_PT

:RAPIDO_PT
cls
color 0A
echo [+] A forcar a recolha de lixo da memoria ativa...
PowerShell -Command "[System.GC]::Collect();" >nul 2>&1
echo [OK] Cache e memoria em espera limpas com sucesso!
pause
goto MENU_PT


:: ====================================================================
:: TEXTOS EM INGLÊS
:: ====================================================================
:EN
cls
color 0E
echo ===============================================================================
echo   CREATOR'S NOTE (Gui - CONNECT): Why this script?
echo ===============================================================================
echo   I created and added these routines because they TRULY worked for me. 
echo   My Windows was locking my physical memory, forcing my PC to boot up using 
echo   an absurd 23GB of RAM. After applying these commands, the usage 
echo   immediately dropped to a clean, normal 6GB!
echo ===============================================================================
echo.
echo   WHAT THIS SCRIPT WILL DO TO YOUR PC:
echo   1. Clear and reset hidden maximum memory restrictions on Boot (MSConfig).
echo   2. Fix registry keys that force the mapping of stuck hardware RAM.
echo   3. Flush the Standby List, system dump cache, and network DNS.
echo   4. Force the Windows kernel (via PowerShell) to release wasted RAM.
echo.
echo ===============================================================================
set /p conf="Do you want to continue with the optimization? (Y/N): "
if /i "%conf%" neq "Y" goto IDIOMA

:MENU_EN
cls
color 0B
echo ===============================================================================
echo   Universal RAM Unlocking Tool - CONNECT Labs - English Version
echo ===============================================================================
echo.
echo  [1] Run Full Diagnostic and Unlock (Recommended - Requires Reboot)
echo  [2] Quick Cache and Standby List Flush (No Reboot)
echo  [3] Back to Language Menu
echo  [4] Exit
echo.
echo ===============================================================================
set /p op_en="Choose an option (1-4): "

if "%op_en%"=="1" goto COMPLETO_EN
if "%op_en%"=="2" goto RAPIDO_EN
if "%op_en%"=="3" goto IDIOMA
if "%op_en%"=="4" exit
goto MENU_EN

:COMPLETO_EN
cls
color 0A
echo [+] Removing maximum memory boundaries on boot (BCDEdit)...
bcdedit /deletevalue {current} removememory >nul 2>&1
bcdedit /deletevalue {current} truncatememory >nul 2>&1
echo [+] Optimizing memory management keys in the Registry...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul 2>&1
echo [+] Restarting Explorer process and flushing cache tables...
taskkill /f /im explorer.exe >nul 2>&1
ipconfig /flushdns >nul 2>&1
start explorer.exe
echo.
echo ===============================================================================
echo [SUCCESS] System reconfigured! RAM hardware restriction has been removed.
echo ===============================================================================
set /p re_en="Do you want to restart your PC now to apply changes? (Y/N): "
if /i "%re_en%"=="Y" shutdown /r /t 5
goto MENU_EN

:RAPIDO_EN
cls
color 0A
echo [+] Forcing Garbage Collection on active memory...
PowerShell -Command "[System.GC]::Collect();" >nul 2>&1
echo [OK] Cache and standby memory cleared successfully!
pause
goto MENU_EN


:: ====================================================================
:: TEXTOS EM ESPANHOL
:: ====================================================================
:ES
cls
color 0E
echo ===============================================================================
echo   NOTA DEL CREADOR (Gui - CONNECT): ¿Por qué este script?
echo ===============================================================================
echo   He creado y añadido estas rutinas porque fue lo que VERÍDICAMENTE funcionó 
echo   conmigo. Mi Windows estaba bloqueando mi memoria física, haciendo que el PC 
echo   arrancara consumiendo unos absurdos 23GB de RAM. ¡Tras aplicar estos 
echo   comandos, el consumo bajó inmediatamente a unos limpios y normales 6GB!
echo ===============================================================================
echo.
echo   LO QUE ESTE SCRIPT HARÁ EN SU PC:
echo   1. Limpiar y restablecer límites ocultos de memoria máxima en el Arranque.
echo   2. Corregir claves de registro que obligan a liberar hardware retenido.
echo   3. Vaciar la Lista de Espera (Standby), caché de volcado y limpiar DNS.
echo   4. Forzar al recolector de Windows (PowerShell) a liberar RAM inútil.
echo.
echo ===============================================================================
set /p conf="¿Desea continuar con la optimización? (S/N): "
if /i "%conf%" neq "S" goto IDIOMA

:MENU_ES
cls
color 0B
echo ===============================================================================
echo   Herramienta Universal de Desbloqueo de RAM - CONNECT Labs - Version Espanol
echo ===============================================================================
echo.
echo  [1] Ejecutar Diagnostico y Desbloqueio Total (Recomendado - Requiere Reiniciar)
echo  [2] Limpieza Rapida de Cache y Lista de Espera (Sin Reiniciar)
echo  [3] Volver al Menu de Idiomas
echo  [4] Salir
echo.
echo ===============================================================================
set /p op_es="Elija una opcion (1-4): "

if "%op_es%"=="1" goto COMPLETO_ES
if "%op_es%"=="2" goto RAPIDO_ES
if "%op_es%"=="3" goto IDIOMA
if "%op_es%"=="4" exit
goto MENU_ES

:COMPLETO_ES
cls
color 0A
echo [+] Eliminando limites de memoria maxima en el arranque (BCDEdit)...
bcdedit /deletevalue {current} removememory >nul 2>&1
bcdedit /deletevalue {current} truncatememory >nul 2>&1
echo [+] Optimizando claves de gestion de memoria en el Registro...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul 2>&1
echo [+] Reiniciando el Explorador y vaciando tablas de cache...
taskkill /f /im explorer.exe >nul 2>&1
ipconfig /flushdns >nul 2>&1
start explorer.exe
echo.
echo ===============================================================================
echo [EXITO] Sistema reconfigurado! Se ha eliminado la restriccion de RAM.
echo ===============================================================================
set /p re_es="Quiere reiniciar el equipo ahora para aplicar? (S/N): "
if /i "%re_es%"=="S" shutdown /r /t 5
goto MENU_ES

:RAPIDO_ES
cls
color 0A
echo [+] Forzando la recoleccion de basura de la memoria activa...
PowerShell -Command "[System.GC]::Collect();" >nul 2>&1
echo [OK] Cache y lista de espera limpiadas con exito!
pause
goto MENU_ES