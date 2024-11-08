data "aws_iam_policy_document" "snyk-iam-policy-document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::370134896156:role/snyk-generate-credentials"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["ZTQxZGRhYjMtOWE3MC00M2YzLTgwYzAtZWVjOTUzOTYzNGM0"]
    }
  }
}

resource "aws_iam_role" "snyk-iam-role" {
  name                = "snyk-cloud-role-d8f46861"
  assume_role_policy  = data.aws_iam_policy_document.snyk-iam-policy-document.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/SecurityAudit"
  ]

  inline_policy {
    name = "Snyk"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Resource = "*"
          Action   = [
            "account:GetAlternateContact",
            "acm-pca:GetCertificateAuthorityCertificate",
            "acm-pca:GetCertificateAuthorityCsr",
            "acm-pca:ListTags",
            "apigateway:GET",
            "athena:GetNamedQuery",
            "athena:GetQueryExecution",
            "athena:GetQueryResults",
            "cloudhsm2:DescribeClusters",
            "cloudwatch:GetDashboard",
            "cloudwatch:ListDashboards",
            "cognito-idp:GetGroup",
            "cognito-idp:GetUserPoolMfaConfig",
            "ds:DescribeConditionalForwarders",
            "ds:ListTagsForResource",
            "elasticfilesystem:DescribeLifecycleConfiguration",
            "elasticfilesystem:DescribeTags",
            "es:GetCompatibleElasticsearchVersions",
            "es:GetUpgradeStatus",
            "glacier:GetVaultNotifications",
            "glacier:ListTagsForVault",
            "glue:GetClassifier",
            "glue:GetConnection",
            "glue:GetConnections",
            "glue:GetCrawler",
            "glue:GetDatabase",
            "glue:GetJob",
            "glue:GetSecurityConfiguration",
            "glue:GetSecurityConfigurations",
            "glue:GetTable",
            "glue:GetTables",
            "glue:GetTags",
            "glue:GetTrigger",
            "glue:GetWorkflow",
            "glue:ListCrawlers",
            "glue:ListJobs",
            "glue:ListTriggers",
            "glue:ListWorkflows",
            "guardduty:DescribeOrganizationConfiguration",
            "lambda:GetAlias",
            "lambda:GetEventSourceMapping",
            "lambda:GetFunction",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:GetLayerVersion",
            "lambda:GetProvisionedConcurrencyConfig",
            "macie:ListMemberAccounts",
            "macie:ListS3Resources",
            "mediastore:DescribeContainer",
            "mediastore:ListTagsForResource",
            "ram:GetResourceShareAssociations",
            "ram:GetResourceShareInvitations",
            "ram:GetResourceShares",
            "sns:GetPlatformApplicationAttributes",
            "sns:GetSMSAttributes",
            "sns:GetSubscriptionAttributes",
            "ssm:GetDocument",
            "ssm:GetMaintenanceWindow",
            "ssm:GetMaintenanceWindowTask",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:GetPatchBaseline",
            "states:DescribeStateMachine",
            "states:ListTagsForResource",
            "waf-regional:Get*",
            "waf-regional:List*",
            "waf:Get*",
            "waf:List*",
            "wafv2:Get*",
            "wafv2:List*"
          ]
        },
      ]
    })
  }
}

output "role_arn" {
  value = aws_iam_role.snyk-iam-role.arn
}
