@echo off
SETLOCAL EnableDelayedExpansion
set condition=true
cd %~dp0
set DIR_EJECUCION=%cd%
set DIR_EJECUCION=%cd%
for %%I in (%DIR_EJECUCION%) do set nombreCarpeta=%%~nxI
REM Inicializa una variable para el arreglo vacío
set misProyectos=""
echo Nota de Recomendacion:
echo - El nombre del proyecto no debe contener simbolos.
echo - Evite usar espacios en blanco.
echo - No incluir numeros.
echo.
pause

:menu
	cls
	echo ==============================
	echo       MENU DE OPCIONES
	echo ==============================
	echo.
	echo 1. Creacion del proyecto 4 Capas
	echo 2. Creacion de carpetas
	echo 3. Salir
	echo.
	SET /P choice="Seleccione una opción (1-3): "

	IF "%choice%"=="1" GOTO selectName
	IF "%choice%"=="2" GOTO carpetas
	IF "%choice%"=="3" GOTO endScript
	GOTO menu

:selectName
    dotnet new sln
    SET /P folderName="Introduce el nombre del proyecto WebApi: "
    dotnet new webapi -o !folderName!
    dotnet add !folderName!\!folderName!.csproj package Microsoft.AspNetCore.Authentication.JwtBearer --version 7.0.10
    dotnet add !folderName!\!folderName!.csproj package Microsoft.EntityFrameworkCore --version 7.0.10
    dotnet add !folderName!\!folderName!.csproj package Microsoft.EntityFrameworkCore.Design --version 7.0.10
    dotnet add !folderName!\!folderName!.csproj package Microsoft.Extensions.DependencyInjection --version 7.0.0
    dotnet add !folderName!\!folderName!.csproj package System.IdentityModel.Tokens.Jwt --version 6.32.3
    dotnet add !folderName!\!folderName!.csproj package Serilog.AspNetCore --version 7.0.0
    dotnet add !folderName!\!folderName!.csproj package AutoMapper.Extensions.Microsoft.DependencyInjection --version 12.0.1
    SET app=Application
    dotnet new classlib -o !app!
    SET persistencia=Persistence
    dotnet new classlib -o !persistencia!
    dotnet add !persistencia!\!persistencia!.csproj package Pomelo.EntityFrameworkCore.MySql --version 7.0.0
    dotnet add !persistencia!\!persistencia!.csproj package Microsoft.EntityFrameworkCore --version 7.0.10
    dotnet add !persistencia!\!persistencia!.csproj package CsvHelper --version 30.0.1
    SET dom=Domain
    dotnet new classlib -o !dom!
    dotnet add !dom!\!dom!.csproj package FluentValidation.AspNetCore --version 11.3.0
    dotnet add !dom!\!dom!.csproj package itext7.pdfhtml --version 5.0.1
    dotnet add !dom!\!dom!.csproj package Microsoft.EntityFrameworkCore --version 7.0.10
    REM Agregando proyectos a la solucion
	echo %DIR_EJECUCION%
	pause
    dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %folderName%\%folderName%.csproj
    dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %app%\%app%.csproj
    dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %dom%\%dom%.csproj
    dotnet sln %DIR_EJECUCION%\%nombreCarpeta%.sln add %persistencia%\%persistencia%.csproj
    REM Agregando referencias entre proyectos
	echo %DIR_EJECUCION%\%app%
	pause
    cd %DIR_EJECUCION%\%app%
    dotnet add reference %DIR_EJECUCION%\%dom%\%dom%.csproj
    dotnet add reference %DIR_EJECUCION%\%persistencia%\%persistencia%.csproj
    cd %DIR_EJECUCION%\%folderName%
    dotnet add reference %DIR_EJECUCION%\%app%\%app%.csproj
    cd %DIR_EJECUCION%\%persistencia%
    dotnet add reference %DIR_EJECUCION%\%dom%\%dom%.csproj
    pause
	GOTO menu
:carpetas
	cls
    SET rootDir=%driveLetter%:\%projectName%
	echo ===========================================================
	echo       MENU DE OPCIONES SELECCIONE EL GRUPO DE CARPETAS
	echo ===========================================================
	echo.
	echo 1. Dtos,Services,Extensions,Helpers,Profiles (Recomendado WebApi)
	echo 2. Repository,UnitOfWork (Recomendado Application)
	echo 3. Entities,Interfaces (Recomendado Domain)
	echo 4. Data (Recomendado Persistence)
	echo 5. Regresar al menu principal
	echo.
	SET /P choice="Seleccione una opción (1-5): "

	IF "%choice%"=="1" GOTO webapi
	IF "%choice%"=="2" GOTO app
	IF "%choice%"=="3" GOTO domain
	IF "%choice%"=="4" GOTO persistence
	GOTO menu
	:webapi
	   SET /P folderName="Introduce el nombre del proyecto WebApi: "
	   cd %DIR_EJECUCION%\%folderName%
	   mkdir Dtos
	   mkdir Services
	   mkdir Extensions
	   mkdir Helpers
	   mkdir Profiles
	   GOTO carpetas
	:app
	   SET folderName=Application
	   cd %DIR_EJECUCION%\%folderName%
	   mkdir Repository
	   mkdir UnitOfWork
	   GOTO carpetas
	:domain
	   SET folderName=Domain
	   cd %DIR_EJECUCION%\%folderName%
	   mkdir Entities
	   mkdir Interfaces
	   GOTO carpetas
	:persistence
	   SET folderName=Persistence
	   cd %DIR_EJECUCION%\%folderName%
	   mkdir Data
	   cd %DIR_EJECUCION%\%folderName%\Data
	   mkdir Configuration
	   pause
	   GOTO carpetas
:endScript
   echo Gracias por usar nuestro selector!
   exit
ENDLOCAL