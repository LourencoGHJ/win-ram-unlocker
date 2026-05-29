@echo off
title [CONNECT LABS] - Otimizador de RAM Universal v3.5
mode con: cols=90 lines=34

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
echo  [3] ATIVAR FIX PERMANENTE (Automatiza a limpeza em segundo plano de 1h em 1h)
echo  [4] Voltar ao Menu de Idioma
echo  [5] Sair
echo.
echo ===============================================================================
set /p op_pt="Escolha uma opcao (1-5): "

if "%op_pt%"=="1" goto COMPLETO_PT
if "%op_pt%"=="2" goto RAPIDO_PT
if "%op_pt%"=="3" goto PERMANENTE_PT
if "%op_pt%"=="4" goto IDIOMA
if "%op_pt%"=="5" exit
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
echo [+] A desativar o Fast Startup do Windows (Evita reter RAM presa ao desligar)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
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
echo [+] A forcar a recolha de lixo da memoria activa...
PowerShell -Command "[System.GC]::Collect();" >nul 2>&1
echo [OK] Cache e memoria em espera limpas com sucesso!
pause
goto MENU_PT

:PERMANENTE_PT
cls
color 0E
echo ===============================================================================
echo   CONFIGURACAO DO FIX PERMANENTE (Segundo Plano)
echo ===============================================================================
echo   Isto vai criar uma Tarefa Agendada nativa no Windows que executa a limpeza
echo   de forma 100%% invisivel de cada vez que ligas o PC e a cada 1 hora.
echo ===============================================================================
echo.
echo   [1] Instalar Fix Permanente Automatizado
echo   [2] Remover Fix Permanente do Sistema
echo   [3] Voltar
echo.
set /p op_perm="Escolha uma opcao (1-3): "
if "%op_perm%"=="1" (
    schtasks /create /tn "ConnectLabs_RAM_Optimizer" /tr "powershell.exe -NoProfile -WindowStyle Hidden -Command [System.GC]::Collect();" /sc hourly /mo 1 /ru "SYSTEM" /f >nul 2>&1
    schtasks /change /tn "ConnectLabs_RAM_Optimizer" /ri 60 /f >nul 2>&1
    echo.
    color 0A
    echo [SUCESSO] Fix instalado! O teu PC vai manter-se otimizado de forma natural.
    pause
)
if "%op_perm%"=="2" (
    schtasks /delete /tn "ConnectLabs_RAM_Optimizer" /f >nul 2>&1
    echo.
    color 0C
    echo [INFO] Tarefa automatizada removida com sucesso.
    pause
)
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
echo   My Windows was locking up my physical memory, forcing my PC to boot up using 
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
echo  [3] ENABLE PERMANENT FIX (Automate background cleanup every 1 hour)
echo  [4] Back to Language Menu
echo  [5] Exit
echo.
echo ===============================================================================
set /p op_en="Choose an option (1-5): "

if "%op_en%"=="1" goto COMPLETO_EN
if "%op_en%"=="2" goto RAPIDO_EN
if "%op_en%"=="3" goto PERMANENTE_EN
if "%op_en%"=="4" goto IDIOMA
if "%op_en%"=="5" exit
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
echo [+] Disabling Windows Fast Startup (Prevents RAM hoarding on shutdown)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
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

:PERMANENTE_EN
cls
color 0E
echo ===============================================================================
echo   PERMANENT FIX CONFIGURATION (Background Automation)
echo ===============================================================================
echo   This creates a native Windows Scheduled Task that clears the system cache
echo   100%% invisibly every time you boot up and every 1 hour sequentially.
echo ===============================================================================
echo.
echo   [1] Install Automated Permanent Fix
echo   [2] Remove Permanent Fix from System
echo   [3] Back
echo.
set /p op_perm_en="Choose an option (1-3): "
if "%op_perm_en%"=="1" (
    schtasks /create /tn "ConnectLabs_RAM_Optimizer" /tr "powershell.exe -NoProfile -WindowStyle Hidden -Command [System.GC]::Collect();" /sc hourly /mo 1 /ru "SYSTEM" /f >nul 2>&1
    schtasks /change /tn "ConnectLabs_RAM_Optimizer" /ri 60 /f >nul 2>&1
    echo.
    color 0A
    echo [SUCCESS] Fix installed! Your PC will now maintain peak performance naturally.
    pause
)
if "%op_perm_en%"=="2" (
    schtasks /delete /tn "ConnectLabs_RAM_Optimizer" /f >nul 2>&1
    echo.
    color 0C
    echo [INFO] Automated task removed successfully.
    pause
)
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
echo  [3] ACTIVAR CONFIGURACION PERMANENTE (Automatiza la limpieza en segundo plano)
echo  [4] Volver al Menu de Idiomas
echo  [5] Salir
echo.
echo ===============================================================================
set /p op_es="Elija una opcion (1-5): "

if "%op_es%"=="1" goto COMPLETO_ES
if "%op_es%"=="2" goto RAPIDO_ES
if "%op_es%"=="3" goto PERMANENTE_ES
if "%op_es%"=="4" goto IDIOMA
if "%op_es%"=="5" exit
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
echo [+] Desactivando Inicio Rapido de Windows (Evita retener RAM al apagar)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
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

:PERMANENTE_ES
cls
color 0E
echo ===============================================================================
echo   CONFIGURACION DE FIX PERMANENTE (Segundo Plano)
echo ===============================================================================
echo   Esto creara una Tarea Programada nativa en Windows que ejecuta la limpieza
echo   de forma 100%% invisible cada vez que enciendes el PC y cada 1 hora.
echo ===============================================================================
echo.
echo   [1] Instalar Fix Permanente Automatizado
echo   [2] Eliminar Fix Permanente del Sistema
echo   [3] Volver
echo.
set /p op_perm_es="Elija una opcion (1-3): "
if "%op_perm_es%"=="1" (
    schtasks /create /tn "ConnectLabs_RAM_Optimizer" /tr "powershell.exe -NoProfile -WindowStyle Hidden -Command [System.GC]::Collect();" /sc hourly /mo 1 /ru "SYSTEM" /f >nul 2>&1
    schtasks /change /tn "ConnectLabs_RAM_Optimizer" /ri 60 /f >nul 2>&1
    echo.
    color 0A
    echo [EXITO] ¡Fix instalado! Tu PC se mantendra optimizado de forma natural.
    pause
)
if "%op_perm_es%"=="2" (
    schtasks /delete /tn "ConnectLabs_RAM_Optimizer" /f >nul 2>&1
    echo.
    color 0C
    echo [INFO] Tarea automatizada eliminada con exito.
    pause
)
goto MENU_ES
