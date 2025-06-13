@echo off
setlocal enabledelayedexpansion

:: Configurações
set ORIGEM=F:\
set DESTINO=G:\Backup_F\
set LOG="%DESTINO%Backup_Log_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%.txt"

:: Criar pasta de destino se não existir
if not exist "%DESTINO%" (
    mkdir "%DESTINO%"
    echo Pasta de destino criada em: %DESTINO% >> %LOG%
)

:: Iniciar cópia com robocopy (robusto para cópias no Windows)
echo ----------------------------------------- >> %LOG%
echo Backup iniciado em: %date% %time% >> %LOG%
echo Origem: %ORIGEM% >> %LOG%
echo Destino: %DESTINO% >> %LOG%
echo ----------------------------------------- >> %LOG%

robocopy "%ORIGEM%" "%DESTINO%" /E /ZB /COPYALL /R:3 /W:5 /NP /LOG+:%LOG% /TEE

:: Verificar resultado
if %ERRORLEVEL% LEQ 8 (
    echo Backup concluído com sucesso em: %date% %time% >> %LOG%
    echo STATUS: SUCESSO (Código: %ERRORLEVEL%) >> %LOG%
) else (
    echo Backup falhou em: %date% %time% >> %LOG%
    echo STATUS: ERRO (Código: %ERRORLEVEL%) >> %LOG%
)

echo ----------------------------------------- >> %LOG%
endlocal
