# terraform 遊び場

## required

- [tfutils/tfenv: Terraform version manager](https://github.com/tfutils/tfenv)
- [direnv/direnv: unclutter your .profile](https://github.com/direnv/direnv)

```bash
# 以下の設定を行っておくと便利

cat <<END >> .envrc
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION="ap-northeast-1"
END
```

IAMユーザーにアクセスキーを発行し、`~/.aws/config`と`~/.aws/credentials`を設定する。(面倒なので)

- [設定ファイルと認証情報ファイルの設定 - AWS Command Line Interface](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-files.html)

## ssm経由でプライベートサブネットに接続する

```bash
PROFILE=rishikawa

# 接続するインスタンスの情報を取得する
aws --profile $PROFILE ec2 describe-instances

# インスタンスIDをメモしておく
# i-030507a1756a18bab

# SSMのセッションマネージャーを開始する
aws --profile $PROFILE ssm start-session --target i-030507a1756a18bab

```
