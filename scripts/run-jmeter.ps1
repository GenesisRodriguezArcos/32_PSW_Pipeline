# Script para ejecutar pruebas de JMeter
# Uso: .\scripts\run-jmeter.ps1

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Ejecutando Pruebas de JMeter" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Verificar si JMeter está instalado
Write-Host "1. Verificando instalación de JMeter..." -ForegroundColor Yellow
try {
    $jmeterVersion = jmeter -v 2>&1 | Select-String "Apache JMeter"
    if ($jmeterVersion) {
        Write-Host "✅ JMeter está instalado" -ForegroundColor Green
        Write-Host $jmeterVersion -ForegroundColor Gray
        Write-Host ""
    }
} catch {
    Write-Host "❌ JMeter no está instalado o no está en el PATH" -ForegroundColor Red
    Write-Host "   Descarga JMeter de: https://jmeter.apache.org/download_jmeter.cgi" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Verificar si la aplicación está corriendo
Write-Host "2. Verificando si la aplicación está corriendo..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8085/actuator/health" -Method Get -ErrorAction Stop -TimeoutSec 5
    Write-Host "✅ Aplicación está corriendo" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "❌ La aplicación no está corriendo" -ForegroundColor Red
    Write-Host "   Inicia la aplicación con: mvn spring-boot:run" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Limpiar resultados anteriores
Write-Host "3. Limpiando resultados anteriores..." -ForegroundColor Yellow
if (Test-Path "jmeter\results.jtl") {
    Remove-Item "jmeter\results.jtl" -Force
    Write-Host "✅ Archivo results.jtl eliminado" -ForegroundColor Green
}
if (Test-Path "jmeter\report") {
    Remove-Item "jmeter\report" -Recurse -Force
    Write-Host "✅ Carpeta report eliminada" -ForegroundColor Green
}
Write-Host ""

# Ejecutar JMeter
Write-Host "4. Ejecutando pruebas de carga..." -ForegroundColor Yellow
Write-Host "   Test Plan: jmeter\test-plan.jmx" -ForegroundColor Gray
Write-Host "   Usuarios: 75 por endpoint" -ForegroundColor Gray
Write-Host "   Iteraciones: 10 por usuario" -ForegroundColor Gray
Write-Host "   Total peticiones: 1500" -ForegroundColor Gray
Write-Host ""
Write-Host "   Esto puede tomar algunos minutos..." -ForegroundColor Yellow
Write-Host ""

try {
    jmeter -n -t jmeter\test-plan.jmx -l jmeter\results.jtl -e -o jmeter\report
    Write-Host ""
    Write-Host "✅ Pruebas completadas exitosamente" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "❌ Error al ejecutar JMeter" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    exit 1
}

# Abrir reporte
Write-Host "5. Abriendo reporte HTML..." -ForegroundColor Yellow
if (Test-Path "jmeter\report\index.html") {
    Start-Process "jmeter\report\index.html"
    Write-Host "✅ Reporte abierto en el navegador" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "❌ No se pudo encontrar el reporte" -ForegroundColor Red
    Write-Host ""
}

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Proceso completado" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📊 Reporte HTML: jmeter\report\index.html" -ForegroundColor Cyan
Write-Host "📄 Resultados JTL: jmeter\results.jtl" -ForegroundColor Cyan
Write-Host ""
