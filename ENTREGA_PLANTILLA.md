# S11 | AP5 | Reto Individual: Construcción de un Pipeline de Calidad

---

## 👤 Datos del Estudiante

**Nombre Completo:** [Tu nombre completo]  
**Código de Estudiante:** [Tu código]  
**Carrera:** Ingeniería de Software  
**Curso:** Pruebas de Software  
**Fecha de entrega:** [Fecha]  

---

## 1. Captura del Proyecto Funcionando

### 🔧 Compilación Exitosa

```powershell
# Comando ejecutado
mvn clean compile
```

**Captura de pantalla:**  
[Pegar captura aquí mostrando la compilación exitosa]

---

### ▶️ Aplicación en Ejecución

```powershell
# Comando ejecutado
mvn spring-boot:run
```

**Captura de pantalla:**  
[Pegar captura de la aplicación corriendo en el puerto 8085]

---

### 🌐 Pruebas de Endpoints

#### Endpoint: GET /products

**Request:**
```powershell
curl http://localhost:8085/products
```

**Response:**
```json
[Pegar respuesta JSON aquí]
```

**Captura de pantalla:**  
[Pegar captura de Postman/Insomnia/Terminal]

---

#### Endpoint: POST /login

**Request:**
```powershell
curl -X POST http://localhost:8085/login `
  -H "Content-Type: application/json" `
  -d '{\"username\":\"admin\",\"password\":\"123456\"}'
```

**Response:**
```json
[Pegar respuesta JSON aquí]
```

**Captura de pantalla:**  
[Pegar captura de Postman/Insomnia/Terminal]

---

## 2. Captura del Pipeline de Jenkins

### 📊 Vista General del Pipeline

**Captura de pantalla:**  
[Pegar captura mostrando todas las etapas del pipeline]

- ✅ Checkout
- ✅ Build
- ✅ SonarQube Analysis
- ✅ Package
- ✅ Start Application
- ✅ JMeter Load Testing
- ✅ Stop Application

---

### 📝 Detalle de Cada Etapa

#### Stage 1: Checkout
**Captura de pantalla:**  
[Pegar captura del log de Checkout]

**Descripción:**  
En esta etapa se descarga el código fuente desde el repositorio Git. Jenkins clona el repositorio y prepara el workspace para las siguientes etapas.

---

#### Stage 2: Build
**Captura de pantalla:**  
[Pegar captura del log de Build]

**Descripción:**  
Maven compila el código fuente del proyecto. Se ejecuta `mvn clean compile` para asegurar que el proyecto no tiene errores de compilación.

---

#### Stage 3: SonarQube Analysis
**Captura de pantalla:**  
[Pegar captura del log de SonarQube Analysis]

**Descripción:**  
El código es analizado por SonarQube para detectar bugs, vulnerabilidades, code smells y medir la cobertura de código.

---

#### Stage 4: Package
**Captura de pantalla:**  
[Pegar captura del log de Package]

**Descripción:**  
Maven empaqueta la aplicación en un archivo JAR ejecutable que será usado para las pruebas de carga.

---

#### Stage 5: Start Application
**Captura de pantalla:**  
[Pegar captura del log de Start Application]

**Descripción:**  
La aplicación se inicia en el puerto 8085 para que JMeter pueda ejecutar las pruebas de carga contra los endpoints reales.

---

#### Stage 6: JMeter Load Testing
**Captura de pantalla:**  
[Pegar captura del log de JMeter]

**Descripción:**  
JMeter ejecuta pruebas de carga con 75 usuarios concurrentes contra los endpoints GET /products y POST /login.

---

#### Stage 7: Stop Application
**Captura de pantalla:**  
[Pegar captura del log de Stop Application]

**Descripción:**  
La aplicación se detiene correctamente después de completar las pruebas de carga.

---

## 3. Evidencia de SonarQube

### 📊 Dashboard General

**Captura de pantalla del dashboard:**  
[Pegar captura mostrando métricas generales]

---

### 📈 Métricas Principales

| Métrica | Valor | Estado |
|---------|-------|--------|
| **Bugs** | [X] | [🟢/🟡/🔴] |
| **Vulnerabilidades** | [X] | [🟢/🟡/🔴] |
| **Code Smells** | [X] | [🟢/🟡/🔴] |
| **Coverage** | [X%] | [🟢/🟡/🔴] |
| **Duplicaciones** | [X%] | [🟢/🟡/🔴] |
| **Líneas de código** | [X] | - |

**Captura de pantalla:**  
[Pegar captura de las métricas]

---

### 🐛 Detalle de Issues

**Captura de pantalla de la lista de issues:**  
[Pegar captura mostrando la lista completa de problemas detectados]

---

## 4. Identificación de 3 Problemas y Propuestas de Mejora

### 🔴 Problema 1: [Nombre del problema]

**¿Qué problema detectó?**  
[Descripción detallada del problema que detectó SonarQube]

**Ubicación:**
- Archivo: [nombre del archivo]
- Línea: [número de línea]
- Severidad: [Critical/Major/Minor]

**Captura de pantalla:**  
[Pegar captura del problema específico en SonarQube]

**¿Por qué puede afectar al proyecto?**  
[Explicación del impacto de este problema en:
- Seguridad
- Mantenibilidad
- Rendimiento
- Fiabilidad
- etc.]

**¿Qué mejora propondrías?**  
[Propuesta concreta de solución]

**Código actual:**
```java
[Pegar código con el problema]
```

**Código propuesto:**
```java
[Pegar código mejorado]
```

---

### 🟡 Problema 2: [Nombre del problema]

**¿Qué problema detectó?**  
[Descripción detallada del problema]

**Ubicación:**
- Archivo: [nombre del archivo]
- Línea: [número de línea]
- Severidad: [Critical/Major/Minor]

**Captura de pantalla:**  
[Pegar captura del problema]

**¿Por qué puede afectar al proyecto?**  
[Explicación del impacto]

**¿Qué mejora propondrías?**  
[Propuesta de solución]

**Código actual:**
```java
[Código con problema]
```

**Código propuesto:**
```java
[Código mejorado]
```

---

### 🟠 Problema 3: [Nombre del problema]

**¿Qué problema detectó?**  
[Descripción detallada del problema]

**Ubicación:**
- Archivo: [nombre del archivo]
- Línea: [número de línea]
- Severidad: [Critical/Major/Minor]

**Captura de pantalla:**  
[Pegar captura del problema]

**¿Por qué puede afectar al proyecto?**  
[Explicación del impacto]

**¿Qué mejora propondrías?**  
[Propuesta de solución]

**Código actual:**
```java
[Código con problema]
```

**Código propuesto:**
```java
[Código mejorado]
```

---

## 5. Configuración y Resultados de JMeter

### ⚙️ Configuración del Test Plan

**Captura de la configuración en JMeter:**  
[Pegar captura del test plan en JMeter GUI]

---

#### Configuración GET /products

| Parámetro | Valor |
|-----------|-------|
| Número de usuarios (threads) | 75 |
| Ramp-up period (segundos) | 10 |
| Loop count | 10 |
| **Total de peticiones** | **750** |

**Captura de pantalla:**  
[Pegar configuración del Thread Group]

---

#### Configuración POST /login

| Parámetro | Valor |
|-----------|-------|
| Número de usuarios (threads) | 75 |
| Ramp-up period (segundos) | 10 |
| Loop count | 10 |
| **Total de peticiones** | **750** |

**Captura de pantalla:**  
[Pegar configuración del Thread Group]

---

### 📊 Resultados de la Ejecución

#### Dashboard General

**Captura del reporte HTML generado:**  
[Pegar captura del index.html del reporte de JMeter]

---

#### Resultados GET /products

| Métrica | Valor |
|---------|-------|
| Samples | [X] |
| Average (ms) | [X] |
| Min (ms) | [X] |
| Max (ms) | [X] |
| 90th Percentile (ms) | [X] |
| 95th Percentile (ms) | [X] |
| 99th Percentile (ms) | [X] |
| Throughput (req/sec) | [X] |
| Error % | [X%] |

**Captura de pantalla:**  
[Pegar tabla de resultados]

**Gráfico de tiempo de respuesta:**  
[Pegar gráfico]

---

#### Resultados POST /login

| Métrica | Valor |
|---------|-------|
| Samples | [X] |
| Average (ms) | [X] |
| Min (ms) | [X] |
| Max (ms) | [X] |
| 90th Percentile (ms) | [X] |
| 95th Percentile (ms) | [X] |
| 99th Percentile (ms) | [X] |
| Throughput (req/sec) | [X] |
| Error % | [X%] |

**Captura de pantalla:**  
[Pegar tabla de resultados]

**Gráfico de tiempo de respuesta:**  
[Pegar gráfico]

---

#### Comparativa de Endpoints

**Captura del reporte comparativo:**  
[Pegar gráfico comparativo entre ambos endpoints]

---

## 6. Análisis de los Resultados

### 1. ¿Qué endpoint presentó mejor comportamiento?

**Respuesta:**  
[Analizar cuál endpoint tuvo:
- Menor tiempo de respuesta promedio
- Mayor throughput
- Menor porcentaje de errores
- Comportamiento más estable (menor desviación estándar)]

**Justificación:**  
[Explicar por qué con datos concretos]

---

### 2. ¿Cuál presentó mayor tiempo de respuesta?

**Respuesta:**  
[Indicar el endpoint y el tiempo]

**Análisis:**  
[Explicar posibles razones:
- Complejidad de la operación
- Procesamiento de datos
- Validaciones
- etc.]

---

### 3. ¿Se produjeron errores?

**Respuesta:**  
[Sí/No] - [X%] de error

**Detalle de errores (si aplica):**
- Tipo de error: [500, 404, timeout, etc.]
- Cantidad: [X] errores de [total] peticiones
- Endpoint afectado: [GET /products o POST /login]

**Captura de errores:**  
[Si hubo errores, pegar captura de los logs o detalles]

**Análisis de causa:**  
[Explicar qué pudo causar los errores]

---

### 4. ¿El sistema soportó la carga utilizada?

**Respuesta:**  
[Sí/No]

**Justificación:**  
[Analizar:
- Si todas las peticiones fueron atendidas
- Si los tiempos de respuesta se mantuvieron aceptables
- Si hubo degradación del rendimiento
- Si el sistema se mantuvo estable]

**Indicadores:**
- ✅ Tasa de éxito: [X%]
- ✅ Tiempo promedio de respuesta: [X ms]
- ✅ Throughput sostenido: [X req/sec]
- ✅ Sin timeouts o errores críticos

---

### 5. ¿Qué mejora recomendarías a partir de los resultados?

**Recomendaciones:**

#### 🚀 Mejora 1: [Título]
**Descripción:**  
[Explicar la mejora propuesta]

**Beneficio esperado:**  
[Explicar qué se lograría]

**Implementación:**  
[Pasos o tecnología a usar]

---

#### 🚀 Mejora 2: [Título]
**Descripción:**  
[Explicar la mejora propuesta]

**Beneficio esperado:**  
[Explicar qué se lograría]

**Implementación:**  
[Pasos o tecnología a usar]

---

#### 🚀 Mejora 3: [Título]
**Descripción:**  
[Explicar la mejora propuesta]

**Beneficio esperado:**  
[Explicar qué se lograría]

**Implementación:**  
[Pasos o tecnología a usar]

---

## 7. Evidencia de Slack

### 📱 Configuración de Slack

**Captura del workspace de Slack:**  
[Pegar captura mostrando el canal #jenkins-notifications]

**Captura de la configuración en Jenkins:**  
[Pegar captura de la configuración del plugin de Slack en Jenkins]

---

### ✅ Notificación de Éxito

**Captura de la notificación en Slack cuando el pipeline finaliza correctamente:**  
[Pegar captura de Slack mostrando:
- Mensaje de éxito
- Información del build
- Links a reportes]

---

### ❌ Notificación de Error

**Captura de la notificación en Slack cuando el pipeline falla:**  
[Pegar captura de Slack mostrando:
- Mensaje de error
- Información del build
- Link a los logs]

*Nota: Si no pudiste generar un error real, puedes forzar uno temporalmente modificando el código o configuración.*

---

## 8. Conclusiones

### 💡 Aprendizajes Principales

1. **Integración Continua:**  
   [Reflexión sobre lo aprendido en CI/CD]

2. **Calidad de Código:**  
   [Reflexión sobre la importancia del análisis de código con SonarQube]

3. **Pruebas de Carga:**  
   [Reflexión sobre la importancia de conocer el comportamiento bajo carga]

4. **Automatización:**  
   [Reflexión sobre los beneficios de automatizar el proceso]

---

### 🎯 Dificultades Encontradas

1. **[Dificultad 1]**  
   **Problema:** [Descripción]  
   **Solución:** [Cómo lo resolviste]

2. **[Dificultad 2]**  
   **Problema:** [Descripción]  
   **Solución:** [Cómo lo resolviste]

3. **[Dificultad 3]**  
   **Problema:** [Descripción]  
   **Solución:** [Cómo lo resolviste]

---

### 🌟 Valor del Pipeline para un Proyecto Real

[Reflexión sobre:
- Cómo este pipeline ayudaría en un proyecto real
- Qué beneficios aporta al equipo de desarrollo
- Cómo mejora la calidad del software
- Cómo facilita el proceso de desarrollo]

---

### 🚀 Mejoras Futuras

1. **[Mejora 1]**  
   [Descripción de qué agregarías o mejorarías]

2. **[Mejora 2]**  
   [Descripción de qué agregarías o mejorarías]

3. **[Mejora 3]**  
   [Descripción de qué agregarías o mejorarías]

---

### 📝 Reflexión Personal

[Tu reflexión personal sobre:
- La experiencia de implementar el pipeline
- Lo que más te costó
- Lo que más te gustó
- Cómo aplicarías esto en tu carrera profesional
- Qué importancia tiene este conocimiento]

---

## 📚 Referencias

1. Jenkins Documentation: https://www.jenkins.io/doc/
2. SonarQube Documentation: https://docs.sonarqube.org/
3. Apache JMeter Documentation: https://jmeter.apache.org/usermanual/
4. Slack API Documentation: https://api.slack.com/
5. Maven Documentation: https://maven.apache.org/guides/
6. Spring Boot Documentation: https://spring.io/projects/spring-boot

---

## 📎 Anexos

### Archivos del Proyecto

- `Jenkinsfile` - Configuración del pipeline
- `sonar-project.properties` - Configuración de SonarQube
- `jmeter/test-plan.jmx` - Plan de pruebas de JMeter
- `pom.xml` - Configuración de Maven

### Enlaces

- Repositorio Git: [URL]
- SonarQube Project: [URL]
- Documentación adicional: [URLs]

---

**Fecha de entrega:** [Fecha]  
**Firma:** [Tu firma o nombre]

---

*Documento generado para la entrega del Reto Individual S11 | AP5*
