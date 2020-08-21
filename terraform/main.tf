provider "aws" {
  profile = "ebd_awstraining"
  region = var.region
}

resource "aws_elastic_beanstalk_application" "fib_app" {
  name = var.project
  description = "App to calculate fibonacci numbers. Docker training app."
}

resource "aws_elastic_beanstalk_environment" "dev_env" {
  name = "${var.project}-dev"
  application = aws_elastic_beanstalk_application.fib_app.name
}

resource "aws_elastic_beanstalk_configuration_template" "tf_template" {
  name = "${var.project}-template-config"
  application = aws_elastic_beanstalk_application.fib_app.name
  solution_stack_name = "64bit Amazon Linux 2018.03 v4.15.1 running Node.js"
}
