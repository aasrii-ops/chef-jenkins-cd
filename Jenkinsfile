pipeline {
  agent any
  triggers { pollSCM('H/2 * * * *') }
  environment { CHEF_LICENSE = 'accept-silent' }
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Lint') { steps { bat 'cookstyle cookbooks/webapp/recipes/default.rb cookbooks/webapp/attributes/default.rb' } }
    stage('Deploy') {
      steps {
        bat 'chef-client -z -c config/client.rb -o "recipe[webapp]"'
      }
    }
    stage('Verify') {
      steps {
        powershell '''
          $r = Invoke-WebRequest http://localhost -UseBasicParsing
          if ($r.Content -notmatch 'Hello from the Chef CD pipeline') { throw 'Page check failed' }
        '''
      }
    }
  }
}
