require_relative "boot"
# アプリケーションの設定を記述するファイル
# 設定はhttps://railsguides.jp/v6.1/configuring.htmlを参照

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsXClone
  class Application < Rails::Application
    config.load_defaults 6.1

    # 環境ごとの設定は、config/environments以下のファイルで行う

    config.time_zone = "Tokyo"
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]

    # ジェネレータの設定
    # 構造を知るためにも、勝手に作られないようあえてfalseにする
    config.generators do |g|
      g.skip_routes true
      g.assets false
      g.helper false
      g.test_framework :rspec
      g.controller_specs false
      g.view_specs false
      g.helper_specs false
      g.routing_specs false
      g.request_specs false
    end

    # アクセス制御のためのhostsの設定
    # 今回はとくに指定しない
    config.hosts = nil

  end
end
