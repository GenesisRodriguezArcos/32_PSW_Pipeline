# Script para ejecutar análisis de SonarQube
# Uso: .\scripts\setup-sonarqube.ps1 <SONAR_TOKEN>
# Ejemplo: .\scripts\setup-sonarqube.ps1 squ_1234567890abcdef

param(
    [Parameter(Mandatory=$false)]
    [string]$SonarToken
)

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Análisis de SonarQube" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Verificar si se proporcionó el token
if ([string]::IsNullOrEmpty($SonarToken)) {
    Write-Host "⚠️  No se proporcionó token de SonarQube" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Opciones:" -ForegroundColor Yellow
    Write-Host "1. Proporciona el token como parámetro:" -ForegroundColor Gray
    Write-Host "   .\scripts\setup-sonarqube.ps1 <TU_TOKEN>" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Genera un token en SonarQube:" -ForegroundColor Gray
    Write-Host "   - Ve a: http://localhost:9000" -ForegroundColor Gray
    Write-Host "   - Login como admin" -ForegroundColor Gray
    Write-Host "   - My Account > Security > Generate Token" -ForegroundColor Gray
    Write-Host ""
    
    # Preguntar si desea continuar sin token (usando configuración por defecto)
    $continue = Read-Host "¿Deseas continuar sin token (usará configuración local)? (s/n)"
    if ($continue -ne "s") {
        exit 0
    }
    Write-Host ""
}

# Verificar Maven
Write-Host "1. Verificando Maven..." -ForegroundColor Yellow
try {
    $mavenVersion = mvn -version 2>&1 | Select-String "Apache Maven"
    if ($mavenVersion) {
        Write-Host "✅ Maven está instalado" -ForegroundColor Green
        Write-Host $mavenVersion -ForegroundColor Gray
        Write-Host ""
    }
} catch {
    Write-Host "❌ Maven no está instalado" -ForegroundColor Red
    Write-Host ""
    exit 1
}

# Verificar si SonarQube está corriendo
Write-Host "2. Verificando SonarQube..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:9000/api/system/status" -Method Get -ErrorAction Stop -TimeoutSec 5
    $status = ($response.Content | ConvertFrom-Json).status
    if ($status -eq "UP") {
        Write-Host "✅ SonarQube está corriendo" -ForegroundColor Green
        Write-Host ""
    }
} catch {
    Write-Host "❌ SonarQube no está corriendo" -ForegroundColor Red
    Write-Host "   Inicia SonarQube desde su carpeta bin" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Compilar proyecto
Write-Host "3. Compilando proyecto..." -ForegroundColor Yellow
try {
    mvn clean compile -DskipTests
    Write-Host "✅ Compilación exitosa" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "❌ Error en compilación" -ForegroundColor Red
    Write-Host ""
    exit 1
}

# Ejecutar análisis de SonarQube
Write-Host "4. Ejecutando análisis de SonarQube..." -ForegroundColor Yellow
Write-Host "   Esto puede tomar algunos minutos..." -ForegroundColor Gray
Write-Host ""

try {
    if ([string]::IsNullOrEmpty($SonarToken)) {
        # Sin token (configuración local)
        mvn sonar:sonar `
            -Dsonar.projectKey=psw-pipeline-base `
            -Dsonar.host.url=http://localhost:9000
    } else {
        # Con token
        mvn sonar:sonar `
            -Dsonar.projectKey=psw-pipeline-base `
            -Dsonar.host.url=http://localhost:9000 `
            -Dsonar.login=$SonarToken
    }
    
    Write-Host ""
    Write-Host "✅ Análisis completado exitosamente" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "❌ Error al ejecutar análisis" -ForegroundColor Red
    Write-Host ""
    exit 1
}

# Abrir dashboard
Write-Host "5. Abriendo dashboard de SonarQube..." -ForegroundColor Yellow
Start-Process "http://localhost:9000/dashboard?id=psw-pipeline-base"
Write-Host "✅ Dashboard abierto en el navegador" -ForegroundColor Green
Write-Host ""

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Análisis completado" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📊 Dashboard: http://localhost:9000/dashboard?id=psw-pipeline-base" -ForegroundColor Cyan
Write-Host ""
Write-Host "Revisa las métricas:" -ForegroundColor Yellow
Write-Host "  - Bugs" -ForegroundColor Gray
Write-Host "  - Vulnerabilidades" -ForegroundColor Gray
Write-Host "  - Code Smells" -ForegroundColor Gray
Write-Host "  - Coverage" -ForegroundColor Gray
Write-Host "  - Duplicaciones" -ForegroundColor Gray
Write-Host ""
