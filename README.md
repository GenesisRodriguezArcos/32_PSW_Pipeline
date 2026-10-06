# PSW Pipeline - Proyecto Base para CI/CD

Pipeline de Integración Continua con Jenkins, SonarQube, JMeter y Slack

## 📋 Descripción

Este proyecto es una aplicación Spring Boot que implementa un pipeline completo de integración continua. El pipeline incluye:

- ✅ **Compilación** con Maven
- 🔍 **Análisis de calidad** con SonarQube  
- ⚡ **Pruebas de carga** con JMeter
- 💬 **Notificaciones** con Slack

## 🚀 Inicio Rápido

### Prerrequisitos

- Java 17 o superior
- Maven 3.6+
- Jenkins 2.x
- SonarQube 9.x
- Apache JMeter 5.x
- Cuenta de Slack (opcional)

### Compilar y Ejecutar

```powershell
# Compilar el proyecto
mvn clean compile

# Ejecutar la aplicación
mvn spring-boot:run

# La aplicación estará disponible en http://localhost:8085
```

### Probar Endpoints

```powershell
# GET /products
curl http://localhost:8085/products

# POST /login
curl -X POST http://localhost:8085/login `
  -H "Content-Type: application/json" `
  -d '{\"username\":\"admin\",\"password\":\"123456\"}'
```

## 🔧 Scripts Útiles

El proyecto incluye scripts PowerShell para facilitar la ejecución:

### Probar Endpoints
```powershell
.\scripts\test-endpoints.ps1
```

### Ejecutar Análisis de SonarQube
```powershell
.\scripts\setup-sonarqube.ps1 <TU_SONAR_TOKEN>
```

### Ejecutar Pruebas de JMeter
```powershell
.\scripts\run-jmeter.ps1
```

## 📊 Pipeline de Jenkins

El pipeline incluye las siguientes etapas:

1. **Checkout** - Descarga el código del repositorio
2. **Build** - Compila el proyecto con Maven
3. **SonarQube Analysis** - Analiza la calidad del código
4. **Package** - Empaqueta la aplicación en JAR
5. **Start Application** - Inicia la aplicación para pruebas
6. **JMeter Load Testing** - Ejecuta pruebas de carga
7. **Stop Application** - Detiene la aplicación

### Configurar Pipeline

1. Crear nuevo item en Jenkins (tipo Pipeline)
2. Configurar repositorio Git
3. Especificar `Jenkinsfile` como script del pipeline
4. Guardar y ejecutar

## 📚 Documentación

- **PIPELINE_GUIDE.md** - Guía completa de configuración e implementación
- **ENTREGA_PLANTILLA.md** - Plantilla para documento de entrega
- **sonar-project.properties** - Configuración de SonarQube
- **Jenkinsfile** - Definición del pipeline
- **jmeter/test-plan.jmx** - Plan de pruebas de carga

## 🧪 Pruebas de Carga

Las pruebas de JMeter están configuradas para:

- **75 usuarios concurrentes** por endpoint
- **10 iteraciones** por usuario
- **Ramp-up de 10 segundos**
- **Total: 1500 peticiones** (750 por endpoint)

## 📦 Estructura del Proyecto

```
32_PSW_Pipeline/
├── src/
│   └── main/
│       ├── java/
│       │   └── vallegrande/edu/pe/
│       │       ├── controller/
│       │       │   ├── AuthController.java
│       │       │   └── ProductController.java
│       │       ├── model/
│       │       │   ├── LoginRequest.java
│       │       │   └── Product.java
│       │       ├── service/
│       │       │   └── ProductService.java
│       │       └── PswPipelineBaseApplication.java
│       └── resources/
│           └── application.properties
├── jmeter/
│   └── test-plan.jmx
├── scripts/
│   ├── test-endpoints.ps1
│   ├── run-jmeter.ps1
│   └── setup-sonarqube.ps1
├── Jenkinsfile
├── sonar-project.properties
├── PIPELINE_GUIDE.md
├── ENTREGA_PLANTILLA.md
├── pom.xml
└── README.md
```

## 🎯 Endpoints

### GET /products
Retorna lista de productos disponibles

**Response:**
```json
[
  {
    "id": 1,
    "name": "Laptop",
    "price": 1200.0
  },
  ...
]
```

### POST /login
Autentica usuario

**Request:**
```json
{
  "username": "admin",
  "password": "123456"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login correcto",
  "token": "ABC123XYZ"
}
```

## 🛠️ Tecnologías

- **Spring Boot 3.5.6** - Framework principal
- **Maven** - Gestión de dependencias
- **Jenkins** - Automatización de pipeline
- **SonarQube** - Análisis de calidad de código
- **JaCoCo** - Cobertura de código
- **Apache JMeter** - Pruebas de carga
- **Slack** - Notificaciones

## 📈 Métricas de Calidad

El proyecto monitorea:

- Bugs y vulnerabilidades
- Code smells
- Cobertura de código
- Duplicaciones
- Deuda técnica

## 🤝 Contribuir

Este es un proyecto académico para demostrar la implementación de un pipeline de CI/CD.

## 📄 Licencia

Proyecto académico - Instituto Vallegrande

## 👤 Autor

[Tu nombre]  
Curso: Pruebas de Software  
Instituto Vallegrande

## 🔗 Enlaces

- [Guía completa del pipeline](PIPELINE_GUIDE.md)
- [Plantilla de entrega](ENTREGA_PLANTILLA.md)
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [SonarQube Documentation](https://docs.sonarqube.org/)
- [JMeter Documentation](https://jmeter.apache.org/usermanual/)

---

**Nota:** Para instrucciones detalladas de configuración, consulta [PIPELINE_GUIDE.md](PIPELINE_GUIDE.md)