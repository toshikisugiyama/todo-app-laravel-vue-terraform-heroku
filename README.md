# Todo App Terraform for Heroku

## Herokuにログインして承認を得る
See [here](https://devcenter.heroku.com/articles/using-terraform-with-heroku#set-up-terraform#authorization) for heroku authorization.
### ログイン

```
heroku login
```
### 承認のトークンを作成する
`--description` 設定した値は、人が認識できるラベルのような役割

```
heroku authorizations:create --description 値
```

### IDを確認する
承認を一覧表示させてIDを確認する。
トークン作成の際に `--descriptions` で設定した値はIDではない。
```
heroku authorizations
```

### IDと紐づく承認情報を確認する

```
heroku authorizations:info ID
```
以下のように表示される。
この後Tokenの値を使用する。
```
Client: 値
ID: 値
Description: 値
Scope: 値
Token: 値
Updated at: 値
```

### `terraform.tfvars` を作成する

`terraform.tfvars.example` をコピーする。

```
cp terraform.tfvars.example terraform.tfvars
```
変数を設定する。

```
HEROKU_EMAIL =
HEROKU_API_KEY =
APP_KEY =
APP_URL =
APP_NAME =
DATABASE_URL =
SANCTUM_STATEFUL_DOMAINS =
APP_SOURCE =
```
`HEROKU_API_KEY` にTokenの値を入れる。
`HEROKU_EMAIL` にはEmailアドレスを入れる。

Emailアドレスは

```
heroku whoami
```

で確認できる。

他の変数も設定する。

## Terraform
### Terraformを初期化する

```
terraform init
```
### 変更の差異を確認する

```
terraform plan
```
### Terraformを適用する

```
terraform apply
```

### 環境変数を確認する
```
heroku config -a todo-app-2020-toshikisugiyama
```

### `DATABASE_URL` を設定する
内容は `CLEARDB_DATABASE_URL` と同じにする。

```
heroku config:set DATABASE_URL=値 -a todo-app-2020-toshikisugiyama
```
`DATABASE_URL` に `driver://username:password@host:port/database?options` の形でデータベース情報を設定することで[Laravelとデータベースを接続できる](https://readouble.com/laravel/8.x/ja/database.html#configuration-using-urls)。

### データベースのマイグレーションをする

```
heroku run -a todo-app-2020-toshikisugiyama 'php artisan migrate'
```

### Herokuで公開したサービスを削除するときは

```
terraform destroy
```