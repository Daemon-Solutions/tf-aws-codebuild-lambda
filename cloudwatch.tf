resource "aws_cloudwatch_event_rule" "events" {
  name = "${var.codebuild_name}-events"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.codebuild"
  ],
  "detail-type": [
    "CodeBuild Build State Change"
  ],
  "detail": {
    "build-status": ${jsonencode(var.codebuild_status)},
    "project-name": ["${var.codebuild_name}"] 
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "events" {
  target_id = "${var.codebuild_name}-events"
  rule      = "${aws_cloudwatch_event_rule.events.name}"
  arn       = "${var.lambda_function_arn}"
}

resource "aws_lambda_permission" "events" {
  statement_id  = "${var.codebuild_name}-events"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.events.arn}"
}
