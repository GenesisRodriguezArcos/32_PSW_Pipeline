# Script para probar los endpoints de la aplicación
# Uso: .\scripts\test-endpoints.ps1

$APP_HOST = "localhost"
$APP_PORT = "8085"
$BASE_URL = "http://${APP_HOST}:${APP_PORT}"

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Probando Endpoints del Proyecto" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Verificar si la aplicación está corriendo
Write-Host "1. Verificando si la aplicación está corriendo..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "$BASE_URL/actuator/health" -Method Get -ErrorAction Stop
    Write-Host "✅ Aplicación está corriendo en puerto $APP_PORT" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "❌ Error: La aplicación no está corriendo en puerto $APP_PORT" -ForegroundColor Red
    Write-Host "   Ejecuta primero: mvn spring-boot:run" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Probar GET /products
Write-Host "2. Probando GET /products" -ForegroundColor Yellow
Write-Host "   URL: $BASE_URL/products" -ForegroundColor Gray
try {
    $response = Invoke-RestMethod -Uri "$BASE_URL/products" -Method Get -ContentType "application/json"
    Write-Host "✅ Respuesta exitosa:" -ForegroundColor Green
    $response | ConvertTo-Json -Depth 10 | Write-Host -ForegroundColor White
    Write-Host ""
} catch {
    Write-Host "❌ Error al llamar GET /products" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
}

# Probar POST /login con credenciales correctas
Write-Host "3. Probando POST /login (credenciales correctas)" -ForegroundColor Yellow
Write-Host "   URL: $BASE_URL/login" -ForegroundColor Gray
Write-Host "   Body: {username: 'admin', password: '123456'}" -ForegroundColor Gray
try {
    $body = @{
        username = "admin"
        password = "123456"
    } | ConvertTo-Json
    
    $response = Invoke-RestMethod -Uri "$BASE_URL/login" -Method Post -Body $body -ContentType "application/json"
    Write-Host "✅ Respuesta exitosa:" -ForegroundColor Green
    $response | ConvertTo-Json -Depth 10 | Write-Host -ForegroundColor White
    Write-Host ""
} catch {
    Write-Host "❌ Error al llamar POST /login" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
}

# Probar POST /login con credenciales incorrectas
Write-Host "4. Probando POST /login (credenciales incorrectas)" -ForegroundColor Yellow
Write-Host "   URL: $BASE_URL/login" -ForegroundColor Gray
Write-Host "   Body: {username: 'admin', password: 'wrong'}" -ForegroundColor Gray
try {
    $body = @{
        username = "admin"
        password = "wrong"
    } | ConvertTo-Json
    
    $response = Invoke-RestMethod -Uri "$BASE_URL/login" -Method Post -Body $body -ContentType "application/json"
    Write-Host "✅ Respuesta exitosa:" -ForegroundColor Green
    $response | ConvertTo-Json -Depth 10 | Write-Host -ForegroundColor White
    Write-Host ""
} catch {
    Write-Host "❌ Error al llamar POST /login" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
}

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Pruebas completadas" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
