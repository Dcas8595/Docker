#!groovy

node {

  def err = null
  currentBuild.result = "SUCCESS"

  try { 
    stage 'Checkout'
      checkout scm

    stage 'Validate'
      def packer_file = 'mule.json' 
      print "Running packer validate on : ${packer_file}"
      sh "/usr/local/packer validate ${packer_file}"

    stage 'Build'
      sh "whoami"
      sh "sudo /usr/local/packer build mule.json"  
  }

  catch (caughtError) {
    err = caughtError
    currentBuild.result = "FAILURE"
  }

  finally {
    /* Must re-throw exception to propagate error */
    if (err) {
      throw err
    }
  }
}