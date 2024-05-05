variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

variable "subnet_id" {
  description = "インスタンスを配置するサブネットのID"
  type        = string
}

variable "iam_policy_arns" {
  description = "ロールにアタッチするIAMポリシーのARN"
  type        = set(string)
}

variable "instance_enabled" {
  description = "GPUインスタンスを有効化するか"
  type        = bool
}
