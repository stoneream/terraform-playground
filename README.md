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
