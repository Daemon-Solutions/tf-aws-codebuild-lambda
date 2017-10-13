# tf-aws-codebuild-lambda

This module sets up CloudWatch events to trigger a Lambda function when CodeBuild events occur. For example, you could automatically run a deployment Lambda function after CodeBuild successfully builds a YUM repository.

## Usage

```js
module "codebuild_trigger" {
  source = "../tf-aws-codebuild-lambda"

  codebuild_name   = "${var.yum_repo_codebuild_name}"
  codebuild_status = ["SUCCEEDED"]

  lambda_function_arn  = "${var.deploy_function_arn}"
  lambda_function_name = "${var.deploy_function_name}"
}
```
