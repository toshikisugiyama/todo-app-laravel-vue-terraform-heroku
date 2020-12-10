terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "~> 2.0"
    }
  }
}

provider "heroku" {
  email = var.HEROKU_EMAIL
  api_key = var.HEROKU_API_KEY
}

resource "heroku_app" "default" {
  name = var.APP_NAME
  region = "us"
  config_vars ={
    APP_KEY = var.APP_KEY
    APP_URL = var.APP_URL
    APP_KEY = var.APP_KEY
    APP_NAME = "todo app"
    DATABASE_URL = var.DATABASE_URL
    SESSION_DOMAIN = var.SESSION_DOMAIN
    SANCTUM_STATEFUL_DOMAINS = var.SANCTUM_STATEFUL_DOMAINS
  }
}

resource "heroku_formation" "web" {
  app = heroku_app.default.name
  type = "web"
  quantity = 1
  size = "free"
  depends_on = [heroku_build.default]
}

resource "heroku_addon" "database" {
  app = heroku_app.default.name
  plan = "cleardb:ignite"
}

resource "heroku_build" "default" {
  app = heroku_app.default.id
  source = {
    url = var.APP_SOURCE
  }
}