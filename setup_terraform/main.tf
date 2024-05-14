data "aws_iam_policy_document" "admin-access" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}


module "iam" {
  source              = "./iam"
  count               = length(var.account-names)
  user-name           = var.account-names[count.index]
  iam-policy-document = data.aws_iam_policy_document.admin-access.json
}


resource "local_file" "user_file" {
  content  = jsonencode(module.iam[*].user-details)
  filename = "../users.json"
}

