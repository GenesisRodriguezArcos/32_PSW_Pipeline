pipeline {
    agent any
    
    tools {
        maven 'Maven'
    }
    
    environment {
        // Variables de entorno
        SONAR_HOST_URL = 'http://localhost:9000'
        SONAR_PROJECT_KEY = 'psw-pipeline-base'
        SLACK_CHANNEL = '#jenkins-notifications'
        APP_PORT = '8085'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '=== Iniciando Checkout del código ==='
                checkout scm
                echo 'Código descargado exitosamente'
            }
        }
        
        stage('Build') {
            steps {
                echo '=== Iniciando Build del proyecto ==='
                script {
                    if (isUnix()) {
                        sh 'mvn clean compile -DskipTests'
                    } else {
                        bat 'mvn clean compile -DskipTests'
                    }
                }
                echo 'Build completado exitosamente'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                echo '=== Iniciando análisis de SonarQube ==='
                echo '⚠️  SonarQube no configurado aún - Saltando análisis'
                echo 'Esta etapa se activará después de configurar SonarQube'
                // TODO: Descomentar después de configurar SonarQube
                // script {
                //     withSonarQubeEnv('SonarQube') {
                //         if (isUnix()) {
                //             sh '''
                //                 mvn sonar:sonar \
                //                   -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                //                   -Dsonar.host.url=${SONAR_HOST_URL}
                //             '''
                //         } else {
                //             bat '''
                //                 mvn sonar:sonar ^
                //                   -Dsonar.projectKey=%SONAR_PROJECT_KEY% ^
                //                   -Dsonar.host.url=%SONAR_HOST_URL%
                //             '''
                //         }
                //     }
                // }
                echo 'Etapa SonarQube completada (modo prueba)'
            }
        }
        
        stage('Package') {
            steps {
                echo '=== Empaquetando aplicación ==='
                script {
                    if (isUnix()) {
                        sh 'mvn package -DskipTests'
                    } else {
                        bat 'mvn package -DskipTests'
                    }
                }
                echo 'Aplicación empaquetada exitosamente'
            }
        }
        
        stage('Start Application') {
            steps {
                echo '=== Iniciando aplicación para pruebas ==='
                script {
                    if (isUnix()) {
                        sh '''
                            nohup java -jar target/*.jar > app.log 2>&1 &
                            echo $! > app.pid
                            sleep 15
                        '''
                    } else {
                        bat '''
                            start /B java -jar target\\psw-pipeline-base-0.0.1-SNAPSHOT.jar
                            timeout /t 15
                        '''
                    }
                }
                echo 'Aplicación iniciada en puerto ' + env.APP_PORT
            }
        }
        
        stage('JMeter Load Testing') {
            steps {
                echo '=== Ejecutando pruebas de carga con JMeter ==='
                echo '⚠️  JMeter no configurado aún - Saltando pruebas'
                echo 'Esta etapa se activará después de instalar JMeter'
                // TODO: Descomentar después de instalar JMeter
                // script {
                //     if (isUnix()) {
                //         sh '''
                //             jmeter -n -t jmeter/test-plan.jmx \
                //                    -l jmeter/results.jtl \
                //                    -e -o jmeter/report
                //         '''
                //     } else {
                //         bat '''
                //             jmeter -n -t jmeter\\test-plan.jmx ^
                //                    -l jmeter\\results.jtl ^
                //                    -e -o jmeter\\report
                //         '''
                //     }
                // }
                echo 'Etapa JMeter completada (modo prueba)'
            }
        }
        
        stage('Stop Application') {
            steps {
                echo '=== Deteniendo aplicación ==='
                script {
                    if (isUnix()) {
                        sh '''
                            if [ -f app.pid ]; then
                                kill $(cat app.pid) || true
                                rm app.pid
                            fi
                        '''
                    } else {
                        bat '''
                            for /f "tokens=5" %%a in ('netstat -aon ^| find ":%APP_PORT%" ^| find "LISTENING"') do taskkill /F /PID %%a
                        '''
                    }
                }
                echo 'Aplicación detenida'
            }
        }
    }
    
    post {
        success {
            echo '=== Pipeline ejecutado exitosamente ==='
            echo '✅ Todas las etapas completadas'
            // TODO: Descomentar después de configurar Slack
            // script {
            //     slackSend(
            //         channel: env.SLACK_CHANNEL,
            //         color: 'good',
            //         message: """
            //             ✅ *Pipeline ejecutado exitosamente*
            //             Proyecto: ${env.JOB_NAME}
            //             Build: ${env.BUILD_NUMBER}
            //             Duración: ${currentBuild.durationString}
            //         """
            //     )
            // }
        }
        
        failure {
            echo '=== Pipeline falló ==='
            echo '❌ Revisa los logs para más detalles'
            // TODO: Descomentar después de configurar Slack
            // script {
            //     slackSend(
            //         channel: env.SLACK_CHANNEL,
            //         color: 'danger',
            //         message: """
            //             ❌ *Pipeline falló*
            //             Proyecto: ${env.JOB_NAME}
            //             Build: ${env.BUILD_NUMBER}
            //         """
            //     )
            // }
        
        always {
            echo '=== Limpiando workspace ==='
            cleanWs()
        }
    }
}
