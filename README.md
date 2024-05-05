# terraform 遊び場

## required

- [AWS コマンドラインインターフェイス](https://aws.amazon.com/jp/cli/)
- [tfutils/tfenv: Terraform version manager](https://github.com/tfutils/tfenv)
- [direnv/direnv: unclutter your .profile](https://github.com/direnv/direnv)

### Terraform用のトークンの設定

```bash
# 当リポジトリのディレクトリで設定を行っておくと便利

cat <<END >> .envrc
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION="ap-northeast-1"
END
```

### AWS CLIを操作するユーザー

IAMユーザーにアクセスキーを発行し、`~/.aws/config`と`~/.aws/credentials`を設定する方式。(面倒なので)

- [設定ファイルと認証情報ファイルの設定 - AWS Command Line Interface](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-files.html)

## ssm経由でプライベートサブネットに接続する

```bash
PROFILE=rishikawa

# 接続するインスタンスの情報を取得する
# インスタンス名 = gpu-instance & 状態 = 実行中
aws --profile $PROFILE ec2 describe-instances \
  --filters "Name=tag:Name,Values=gpu-instance" \
  "Name=instance-state-name,Values=running" \
  --query "Reservations[].Instances[].InstanceId" \
  --output text

TARGET="i-0feb81f54ca8dff75"

# SSMのセッションマネージャーを開始する
aws --profile $PROFILE ssm start-session \
--target $TARGET

# 7860と8080にポートフォワーディング (StableDiffusion用)
./bin/port-forward.sh $PROFILE $TARGET
```

## めも

```bash
# モジュール指定で操作する
terraform [plan|apply|destroy] -target=module.[モジュール名]
```

```bash
# modelをS3とSyncする
PREFIX=hoge
WORKSPACE=/home/ubuntu

# S3 -> EC2
aws s3 sync s3://$PREFIX-stable-diffusion/models $WORKSPACE/stable-diffusion-web-ui/models

# EC2 -> S3
aws s3 sync $WORKSPACE/stable-diffusion-webui/models s3://$PREFIX-stable-diffusion/models
```
