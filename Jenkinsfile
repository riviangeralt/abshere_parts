def fortify_enabled = true
def fortify_enableGateCheck = false
def sonar_enabled = false
def nexusIQ_enabled = false

pipeline {
    agent {
        label 'mac-agent011'
    }
    environment {
        def workspace = pwd()
        def fortify_buildId = "masdr-hr-insights.user-interface.hr-insights-mobile-ui.${BRANCH_NAME}"
        
        SOLUTION_NAME = 'masdr-hr-insights'
        COMPONENT_NAME = 'masdr-hr-insights.user-interface.hr-insights-mobile-ui'

        FLUTTERBINWIN = "C:\\flutter-sdk\\flutter_3_27_3\\bin"
        FLUTTERBIN = "$HOME/flutter/flutter_3_27_3/bin"
    }
    stages {
        stage('Flutter Build - WIN') {
             when {
                expression { fortify_enabled == true }
            }
            agent { label 'win-agent03' }  // Specify the agent using its label
            steps {
                script {
                    bat 'where flutter.bat'
                    
                    echo "FLUTTERBINWIN: $FLUTTERBINWIN"
                    
                    bat """
                        echo Flutter Doctor...                  
                        ${FLUTTERBINWIN}\\flutter doctor -v
                    """

                    bat """
                        echo Flutter Clean...
                        ${FLUTTERBINWIN}\\flutter clean
                    """

                    bat """
                        echo Flutter Clean Cache...
                        ${FLUTTERBINWIN}\\flutter clean cache
                    """

                    bat """
                        echo Flutter Pub Get...
                        ${FLUTTERBINWIN}\\flutter pub get
                    """

                    bat """
                        echo Flutter Build...
                        ${FLUTTERBINWIN}\\flutter build web --release --dart-define-from-file=.env.qa
                    """
                }
            }
        }
        stage('Fortify') {
            when {
                expression { fortify_enabled == true }
            }
            agent { label 'win-agent03' }  // Specify the agent using its label
            steps {
                script {
                    fortifyUpdate acceptKey: true, locale: 'en', updateServerURL: 'http://ssc.gosi.ins:8080/ssc'
                    fortifyClean addJVMOptions: '', buildID: '${fortify_buildId}', logFile: '${fortify_buildId}.clean.log', maxHeap: ''
                    //fortifyTranslate addJVMOptions: '', buildID: '${fortify_buildId}', debug: true, excludeList: '', logFile: '${fortify_buildId}.translate.log', maxHeap: '', projectScanType: fortifyMSBuild(dotnetAddOptions: '"/p:Configuration=Debug" "/p:DeployOnBuild=true" "/p:WebPublishMethod=Package" "/p:PackageAsSingleFile=true" "/p:PackageLocation=PackageLocation/" "/p:UseWPP_CopyWebApplication=true" "/p:OutDir=OutDir/"', dotnetProject: '${fortify_projectsFilter}'), verbose: true
                    fortifyTranslate addJVMOptions: '', buildID: '${fortify_buildId}', debug: true, excludeList: '', logFile: '${fortify_buildId}.translate.log', maxHeap: '', projectScanType: fortifyOther(otherIncludesList: '"**/*.dart"'), verbose: true
                    fortifyScan addJVMOptions: '', addOptions: '', buildID: '${fortify_buildId}', customRulepacks: '', debug: true, logFile: '${fortify_buildId}.scan.log', maxHeap: '', resultsFile: '${fortify_buildId}.fpr', verbose: true
                    
                    if (env.BRANCH_NAME.startsWith('release_')) {
                        fortifyUpload appName: "masdr-hr-insights", appVersion: "masdr-hr-insights.user-interface.hr-insights-mobile-ui.release", failureCriteria: "[fortify priority order]:critical OR [fortify priority order]:high", filterSet: "a243b195-0a59-3f8b-1403-d55b7a7d78e6", pollingInterval: "1", resultsFile: "${fortify_buildId}.fpr", timeout: "10" 
                    }
                    else if (env.BRANCH_NAME.startsWith('hotfix_')) {
                        fortifyUpload appName: "masdr-hr-insights", appVersion: "masdr-hr-insights.user-interface.hr-insights-mobile-ui.hotfix", failureCriteria: "[fortify priority order]:critical OR [fortify priority order]:high", filterSet: "a243b195-0a59-3f8b-1403-d55b7a7d78e6", pollingInterval: "1", resultsFile: "${fortify_buildId}.fpr", timeout: "10" 
                    }
                    else if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main') {
                        fortifyUpload appName: "masdr-hr-insights", appVersion: "masdr-hr-insights.user-interface.hr-insights-mobile-ui.main", failureCriteria: "[fortify priority order]:critical OR [fortify priority order]:high", filterSet: "a243b195-0a59-3f8b-1403-d55b7a7d78e6", pollingInterval: "1", resultsFile: "${fortify_buildId}.fpr", timeout: "10" 
                    }
                    else {
                        fortifyUpload appName: "masdr-hr-insights", appVersion: "masdr-hr-insights.user-interface.hr-insights-mobile-ui.feature", failureCriteria: "[fortify priority order]:critical OR [fortify priority order]:high", filterSet: "a243b195-0a59-3f8b-1403-d55b7a7d78e6", pollingInterval: "1", resultsFile: "${fortify_buildId}.fpr", timeout: "10"  
                    }

                    if (currentBuild.result == 'UNSTABLE' && fortify_enableGateCheck == true) {
                        throw new Exception("Fortify Gate-Check failed.")
                    }

                }
            }
        }
        stage('Flutter Build on MAC') {
            steps {
                script {
                    sh 'ls -la'
                    sh 'rm -rf artifact'
                    sh 'mkdir -p artifact'

                    sh '$FLUTTERBIN/flutter doctor -v'
                    sh '$FLUTTERBIN/flutter clean'
                    sh '$FLUTTERBIN/flutter clean cache'
                    sh '$FLUTTERBIN/flutter pub get'

                    if (env.BRANCH_NAME.startsWith('release_') || env.BRANCH_NAME.startsWith('hotfix_')) {

                        sh 'echo --------------------BUILD QA------------------------'
                        sh '$FLUTTERBIN/flutter build web --release --dart-define-from-file=.env.qa  --verbose'
                        sh 'ls -la build/web'
                        sh 'cd build/web && /usr/bin/zip -r -v ../../artifact/qa.masdr-hr-insights.zip ./*'
                        sh 'ls -la artifact'

                        sh 'echo --------------------BUILD UAT-----------------------'
                        sh '$FLUTTERBIN/flutter build web --release --dart-define-from-file=.env.uat  --verbose'
                        sh 'ls -la build/web'
                        sh 'cd build/web && /usr/bin/zip -r -v ../../artifact/uat.masdr-hr-insights.zip ./*'
                        sh 'ls -la artifact'

                        sh 'echo --------------------BUILD PROD----------------------'
                        sh '$FLUTTERBIN/flutter build web --release --dart-define-from-file=.env.prod  --verbose'
                        sh 'ls -la build/web'
                        sh 'cd build/web && /usr/bin/zip -r -v ../../artifact/prod.masdr-hr-insights.zip ./*'
                        sh 'ls -la artifact'

                    }
                    else {

                        sh 'echo --------------------BUILD DEV------------------------'
                        sh '$FLUTTERBIN/flutter build web --release --dart-define-from-file=.env.dev  --verbose'
                        sh 'ls -la build/web'
                        sh 'cd build/web && /usr/bin/zip -r -v ../../artifact/dev.masdr-hr-insights.zip ./*'
                        sh 'ls -la artifact'

                    }

                    
                }
            }
        }
        stage("Push Artifact UCD") {
            steps {
                script {
                    if (env.BRANCH_NAME.startsWith('release_') || env.BRANCH_NAME.startsWith('hotfix_')) {
                        step([$class   : 'UCDeployPublisher',
                            component: [
                                    componentName: "masdr-hr-insights.user-interface.hr-insights-mobile-ui.release",
                                    componentTag : '',
                                    delivery     : [$class             : 'Push',
                                                    baseDir            : "${WORKSPACE}/artifact",
                                                    fileExcludePatterns: '',
                                                    fileIncludePatterns: '',
                                                    pushDescription    : '',
                                                    pushIncremental    : false,
                                                    pushProperties     : '',
                                                    pushVersion        : "${BRANCH_NAME}-${BUILD_TIMESTAMP}"]],
                            siteName : 'IBM UrbanCode Deploy'])
                    }
                    else {
                        step([$class   : 'UCDeployPublisher',
                            component: [
                                    componentName: "masdr-hr-insights.user-interface.hr-insights-mobile-ui.dev",
                                    componentTag : '',
                                    delivery     : [$class             : 'Push',
                                                    baseDir            : "${WORKSPACE}/artifact",
                                                    fileExcludePatterns: '',
                                                    fileIncludePatterns: '',
                                                    pushDescription    : '',
                                                    pushIncremental    : false,
                                                    pushProperties     : '',
                                                    pushVersion        : "${BRANCH_NAME}-${BUILD_TIMESTAMP}"]],
                            siteName : 'IBM UrbanCode Deploy'])

                    }
                }
            }
        }
        stage("UCD Deploy") {
            steps {
                script {
                    if (env.BRANCH_NAME.startsWith('release_') || env.BRANCH_NAME.startsWith('hotfix_')) {

                    }
                    else {
                        step([$class  : 'UCDeployPublisher',
                            deploy  : [
                                    deployApp        : 'Masdr-HR-Insights',
                                    deployDesc       : 'Requested from Jenkins',
                                    deployEnv        : 'Development',
                                    deployOnlyChanged: true,
                                    deployProc       : 'Install masdr-hr-insights',
                                    deployReqProps   : '',
                                    deployVersions   : 'masdr-hr-insights.user-interface.hr-insights-mobile-ui.dev:${BRANCH_NAME}-${BUILD_TIMESTAMP}'],
                            siteName: 'IBM UrbanCode Deploy'])
                    }
                }
            }
        }
    }
}

