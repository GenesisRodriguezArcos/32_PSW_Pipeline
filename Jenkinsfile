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
                echo '⚠️  SonarQube: Configurar antes de usar'
                echo 'Para activar: instalar SonarQube y configurar en Jenkins'
                // TODO: Descomentar después de configurar SonarQube en Jenkins
                // script {
                //     withSonarQubeEnv('SonarQube') {
                //         bat """
                //             mvn sonar:sonar ^
                //               -Dsonar.projectKey=%SONAR_PROJECT_KEY% ^
                //               -Dsonar.host.url=%SONAR_HOST_URL%
                //         """
                //     }
                // }
                echo 'Etapa SonarQube completada'
            }
        }
        
        stage('Package') {
            steps {
                echo '=== Empaquetando aplicación ==='
                bat 'mvn package -DskipTests'
                echo 'Aplicación empaquetada exitosamente'
            }
        }
        
        stage('JMeter Load Testing') {
            steps {
                echo '=== Pruebas de carga con JMeter ==='
                echo '⚠️  JMeter: Configurar antes de usar'
                echo 'Para activar: instalar JMeter y configurar test plan'
                // TODO: Descomentar después de instalar JMeter
                // bat 'jmeter -n -t jmeter\\test-plan.jmx -l jmeter\\results.jtl -e -o jmeter\\report'
                echo 'Etapa JMeter completada'
            }
        }
        
        stage('Notification') {
            steps {
                echo '=== Notificaciones ==='
                echo '✅ Pipeline ejecutado correctamente'
                echo '📧 Notificación: Se pueden configurar con Slack/Email'
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
