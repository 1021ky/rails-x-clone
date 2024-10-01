# typed: strict
Rails.application.routes.draw do
  # 名前空間の名前を定義すると、URLのパスにその名前空間が追加される
  namespace :api do
    # #の前がコントローラー名、#の後がアクション名
    # /apiでアクセスすると、Api::TopControllerのindexアクションが呼び出される
    root "top#index"
  end

  namespace :admin do
    root "top#index"
  end

  namespace :tweet do
    root "top#index"
  end
end
