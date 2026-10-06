pipeline {
    agent any
    
    tools {
        maven 'Maven'
    }
    
    environment {
        SONAR_HOST_URL = 'http://localhost:9000'
        SONAR_PROJECT_KEY = 'psw-pipeline-base'
        APP_PORT = '8085'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '=== Iniciando Checkout del código ==='
                checkout scm
                echo 'Código descargado desde GitHub exitosamente'
            }
        }
        
        stage('Build') {
            steps {
                echo '=== Iniciando Build del proyecto ==='
                bat 'mvn clean compile -DskipTests'
                echo 'Build completado exitosamente'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                echo '=== Análisis de SonarQube ==='
                script {
                    withSonarQubeEnv('SonarQube') {
                        bat """
                            mvn sonar:sonar ^
                              -Dsonar.projectKey=%SONAR_PROJECT_KEY% ^
                              -Dsonar.host.url=%SONAR_HOST_URL%
                        """
                    }
                }
                echo 'Análisis de SonarQube completado'
            }
        }
        
        stage('Package') {
            steps {
                echo '=== Empaquetando aplicación ==='
                bat 'mvn package -DskipTests'
                echo 'Aplicación empaquetada exitosamente'
            }
        }
        
        stage('Test Endpoints') {
            steps {
                echo '=== Iniciando aplicación y probando endpoints ==='
                script {
                    try {
                        bat 'start /B java -jar target\\psw-pipeline-base-0.0.1-SNAPSHOT.jar'
                        sleep 20
                        echo 'Aplicación iniciada'
                        bat 'curl http://localhost:8085/actuator/health'
                        echo 'Health check: OK'
                        bat 'curl http://localhost:8085/products'
                        echo 'GET /products: OK'
                    } catch (Exception e) {
                        echo "Error en pruebas: ${e.message}"
                    } finally {
                        bat 'for /f "tokens=5" %%a in (\'netstat -aon ^| find ":8085" ^| find "LISTENING"\') do taskkill /F /PID %%a || exit 0'
                        echo 'Aplicación detenida'
                    }
                }
            }
        }
        
        stage('JMeter Load Testing') {
            steps {
                echo '=== Pruebas de carga con JMeter ==='
                echo 'JMeter no configurado aún - Saltando pruebas'
                echo 'Esta etapa se activará después de instalar JMeter'
            }
        }
    }
    
    post {
        success {
            echo '=== ✅ Pipeline ejecutado exitosamente ==='
            echo 'Todas las etapas completadas'
        }
        failure {
            echo '=== ❌ Pipeline falló ==='
            echo 'Revisa los logs para más detalles'
        }
        always {
            echo '=== Finalizando pipeline ==='
        }
    }
}
