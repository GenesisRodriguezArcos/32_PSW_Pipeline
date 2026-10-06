# Guía Completa del Pipeline de Calidad

## 📋 Resumen del Proyecto

Este proyecto implementa un pipeline de CI/CD completo que incluye:
- ✅ Compilación con Maven
- 🔍 Análisis de calidad con SonarQube
- ⚡ Pruebas de carga con JMeter
- 💬 Notificaciones con Slack

---

## 1️⃣ Preparación del Proyecto

### Verificar Compilación

```powershell
# Limpiar y compilar el proyecto
mvn clean compile

# Ejecutar la aplicación
mvn spring-boot:run
```

### Probar Endpoints

**GET /products**
```powershell
curl http://localhost:8085/products
```

**POST /login**
```powershell
curl -X POST http://localhost:8085/login `
  -H "Content-Type: application/json" `
  -d '{\"username\":\"admin\",\"password\":\"123456\"}'
```

### Verificar Dependencias

```powershell
mvn dependency:tree
```

---

## 2️⃣ Configurar Jenkins

### Instalación de Jenkins

1. Descargar Jenkins desde: https://www.jenkins.io/download/
2. Instalar Jenkins en Windows
3. Acceder a: http://localhost:8080
4. Completar el asistente de configuración

### Plugins Necesarios

Instalar los siguientes plugins desde "Manage Jenkins" → "Manage Plugins":

- **Pipeline** - Para ejecutar Jenkinsfiles
- **Git** - Para integración con Git
- **Maven Integration** - Para proyectos Maven
- **SonarQube Scanner** - Para análisis de código
- **Slack Notification** - Para notificaciones
- **HTML Publisher** - Para publicar reportes JMeter
- **Performance Plugin** - Para métricas de rendimiento

### Configurar Maven en Jenkins

1. Ir a "Manage Jenkins" → "Global Tool Configuration"
2. En la sección "Maven", agregar una instalación Maven
3. Nombre: `Maven 3.9`
4. Marcar "Install automatically"

### Configurar SonarQube Scanner

1. Ir a "Manage Jenkins" → "Global Tool Configuration"
2. En "SonarQube Scanner", agregar instalación
3. Nombre: `SonarQube Scanner`
4. Marcar "Install automatically"

### Configurar Servidor SonarQube

1. Ir a "Manage Jenkins" → "Configure System"
2. Buscar sección "SonarQube servers"
3. Agregar servidor SonarQube:
   - Name: `SonarQube`
   - Server URL: `http://localhost:9000`
   - Server authentication token: (generar en SonarQube)

### Crear Pipeline en Jenkins

1. Click en "New Item"
2. Nombre: `PSW-Pipeline-Quality`
3. Tipo: "Pipeline"
4. En "Pipeline" → "Definition": "Pipeline script from SCM"
5. SCM: Git
6. Repository URL: (tu repositorio)
7. Branch: `*/main`
8. Script Path: `Jenkinsfile`

---

## 3️⃣ Configurar SonarQube

### Instalación de SonarQube

1. Descargar SonarQube Community Edition:
   - https://www.sonarqube.org/downloads/

2. Extraer y ejecutar:
```powershell
cd sonarqube-x.x.x\bin\windows-x86-64
.\StartSonar.bat
```

3. Acceder a: http://localhost:9000
4. Login inicial:
   - Usuario: `admin`
   - Password: `admin`
   - Cambiar contraseña

### Crear Proyecto en SonarQube

1. Click en "Create Project" → "Manually"
2. Project key: `psw-pipeline-base`
3. Display name: `PSW Pipeline Base`
4. Branch: `main`
5. Generar token de autenticación
6. Guardar el token generado

### Configurar Quality Gate

1. Ir a "Quality Gates"
2. Crear nuevo Quality Gate o usar el predeterminado
3. Condiciones recomendadas:
   - Coverage: > 80%
   - Duplicated Lines: < 3%
   - Maintainability Rating: A
   - Reliability Rating: A
   - Security Rating: A

### Ejecutar Análisis Manual

```powershell
mvn clean verify sonar:sonar `
  -Dsonar.projectKey=psw-pipeline-base `
  -Dsonar.host.url=http://localhost:9000 `
  -Dsonar.login=YOUR_TOKEN_HERE
```

### Interpretar Resultados

En el dashboard de SonarQube verás:

- **Bugs**: Errores en el código que pueden causar fallas
- **Vulnerabilities**: Problemas de seguridad
- **Code Smells**: Problemas de mantenibilidad
- **Coverage**: Porcentaje de código cubierto por tests
- **Duplications**: Código duplicado

---

## 4️⃣ Configurar JMeter

### Instalación de JMeter

1. Descargar Apache JMeter:
   - https://jmeter.apache.org/download_jmeter.cgi

2. Extraer el archivo
3. Agregar JMeter al PATH:
```powershell
$env:PATH += ";C:\path\to\apache-jmeter-x.x\bin"
```

### Configuración del Test Plan

El archivo `jmeter/test-plan.jmx` ya está configurado con:

**GET /products**
- 75 usuarios concurrentes
- 10 iteraciones por usuario
- Ramp-up: 10 segundos
- Total de peticiones: 750

**POST /login**
- 75 usuarios concurrentes
- 10 iteraciones por usuario
- Ramp-up: 10 segundos
- Total de peticiones: 750

### Ejecutar JMeter Manualmente

```powershell
# Modo GUI (para diseñar pruebas)
jmeter

# Modo CLI (para ejecutar pruebas)
jmeter -n -t jmeter\test-plan.jmx `
       -l jmeter\results.jtl `
       -e -o jmeter\report
```

### Abrir Reporte HTML

```powershell
start jmeter\report\index.html
```

### Métricas Importantes

El reporte de JMeter incluye:

1. **Response Time (Tiempo de respuesta)**
   - Average: Tiempo promedio
   - Min/Max: Tiempos mínimo y máximo
   - 90th/95th/99th percentile

2. **Throughput (Rendimiento)**
   - Solicitudes por segundo
   - KB/sec transferidos

3. **Error Rate (Tasa de errores)**
   - % de solicitudes fallidas
   - Tipos de errores

4. **Request Count (Cantidad de solicitudes)**
   - Total de solicitudes exitosas
   - Total de solicitudes fallidas

---

## 5️⃣ Configurar Slack

### Crear Workspace e Integración

1. Crear cuenta en Slack: https://slack.com/
2. Crear un nuevo workspace
3. Crear canal: `#jenkins-notifications`

### Configurar Jenkins Integration

1. En Slack, ir a: https://my.slack.com/services/new/jenkins-ci
2. Seleccionar el canal `#jenkins-notifications`
3. Click en "Add Jenkins CI Integration"
4. Copiar el "Team Subdomain" y "Integration Token"

### Configurar Plugin en Jenkins

1. En Jenkins: "Manage Jenkins" → "Configure System"
2. Buscar "Slack"
3. Configurar:
   - Workspace: (tu workspace)
   - Credential: (crear credential con el token)
   - Default channel: `#jenkins-notifications`
   - Test connection

### Formato de Notificaciones

El Jenkinsfile está configurado para enviar:

**En caso de éxito:**
```
✅ Pipeline ejecutado exitosamente
Proyecto: PSW-Pipeline-Quality
Build: #12
Duración: 3min 45s

📊 SonarQube: [link]
📈 JMeter Report: [link]
```

**En caso de fallo:**
```
❌ Pipeline falló
Proyecto: PSW-Pipeline-Quality
Build: #12
Duración: 1min 30s

Revisa los logs: [link]
```

---

## 6️⃣ Análisis de Resultados

### Análisis de SonarQube

#### Problema 1: [Ejemplo]
- **Qué detectó**: Variables no utilizadas
- **Por qué afecta**: Reduce legibilidad del código
- **Mejora propuesta**: Eliminar variables no utilizadas

#### Problema 2: [Ejemplo]
- **Qué detectó**: Métodos demasiado largos
- **Por qué afecta**: Dificulta el mantenimiento
- **Mejora propuesta**: Refactorizar en métodos más pequeños

#### Problema 3: [Ejemplo]
- **Qué detectó**: Falta de validación de entrada
- **Por qué afecta**: Potencial vulnerabilidad de seguridad
- **Mejora propuesta**: Agregar validaciones con annotations

### Análisis de JMeter

#### Preguntas a Responder:

1. **¿Qué endpoint presentó mejor comportamiento?**
   - Analizar tiempos de respuesta promedio
   - Comparar throughput
   - Revisar tasa de errores

2. **¿Cuál presentó mayor tiempo de respuesta?**
   - Identificar el endpoint más lento
   - Analizar percentiles (p90, p95, p99)

3. **¿Se produjeron errores?**
   - Revisar % de errores
   - Identificar tipos de errores
   - Analizar patrones

4. **¿El sistema soportó la carga utilizada?**
   - Verificar si completó todas las solicitudes
   - Revisar si hubo timeouts
   - Analizar estabilidad

5. **¿Qué mejora recomendarías?**
   - Optimización de consultas
   - Implementar caché
   - Ajustar configuración de servidor
   - Escalar horizontalmente

---

## 7️⃣ Ejecución del Pipeline Completo

### Ejecutar Pipeline desde Jenkins

1. Ir al proyecto en Jenkins
2. Click en "Build Now"
3. Observar el progreso en "Stage View"
4. Revisar logs en "Console Output"

### Verificar Resultados

1. **SonarQube**: http://localhost:9000/dashboard?id=psw-pipeline-base
2. **JMeter Report**: Click en "JMeter Report" en Jenkins
3. **Slack**: Verificar notificación en el canal

---

## 8️⃣ Troubleshooting

### Problemas Comunes

**Error: Maven no encontrado**
```powershell
# Verificar instalación
mvn -version

# Agregar al PATH si es necesario
$env:PATH += ";C:\path\to\maven\bin"
```

**Error: Puerto 8085 en uso**
```powershell
# Encontrar proceso
netstat -ano | findstr :8085

# Matar proceso
taskkill /PID <PID> /F
```

**Error: JMeter no ejecuta**
```powershell
# Verificar Java instalado
java -version

# Verificar JMeter en PATH
jmeter -v
```

**Error: SonarQube no conecta**
- Verificar que SonarQube esté ejecutándose
- Verificar token de autenticación
- Verificar URL en configuración

---

## 9️⃣ Checklist de Entrega

- [ ] Proyecto compila correctamente
- [ ] Endpoints GET /products y POST /login funcionan
- [ ] Pipeline de Jenkins configurado con 5 etapas
- [ ] Análisis de SonarQube ejecutado
- [ ] 3 problemas de código identificados y analizados
- [ ] Pruebas de JMeter configuradas (50-100 usuarios)
- [ ] Reportes de JMeter generados
- [ ] Análisis de resultados de performance completado
- [ ] Notificaciones de Slack configuradas
- [ ] Capturas de pantalla de todas las etapas
- [ ] Documento con conclusiones

---

## 🎯 Conclusiones

En esta sección debes incluir:

1. **Aprendizajes principales** sobre CI/CD
2. **Dificultades encontradas** y cómo las resolviste
3. **Valor del pipeline** para un proyecto real
4. **Mejoras futuras** que implementarías
5. **Reflexión personal** sobre el proceso

---

## 📚 Referencias

- Jenkins Documentation: https://www.jenkins.io/doc/
- SonarQube Documentation: https://docs.sonarqube.org/
- JMeter Documentation: https://jmeter.apache.org/usermanual/
- Slack API: https://api.slack.com/
- Maven Documentation: https://maven.apache.org/guides/

---

## 📧 Contacto y Soporte

Si tienes dudas durante la implementación:
1. Revisar logs detallados en Jenkins Console Output
2. Consultar documentación oficial de cada herramienta
3. Verificar configuraciones en este documento
4. Contactar al docente con evidencias del error

---

**¡Éxito con tu pipeline! 🚀**
