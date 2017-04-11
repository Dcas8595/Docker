#!groovy

node {

  def err = null
  currentBuild.result = "SUCCESS"

  try { 
    stage 'Checkout'
      checkout scm

    stage 'Validate'
      def packer_file = 'packer.json'
      print "Running packer validate on : ${packer_file}"
      sh "/usr/local/packer validate ${packer_file}"

    stage 'Build'
      sh "/usr/local/packer build rabbit.json"
  }
}