# typed: strict

Rails.application.routes.draw do
  # 名前空間の名前を定義すると、URLのパスにその名前空間が追加される
  # namespaceが定義されると、namespaceで指定されたシンボル名のパスの下でアクセスできるリソースを定義できる
  namespace :api do
    # #の前がコントローラー名、#の後がアクション名
    resources :tweet, only: %i[index create]
  end

  namespace :admin do
    root 'top#index'
  end
end
