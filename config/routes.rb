BeadsKoolbzComAu::Application.routes.draw do
  devise_for :flyers, :controllers => { :omniauth_callbacks => "flyers/omniauth_callbacks" }
  root :to => 'showcases#index'
  resources :showcases, :only => ["index"]
  resources :orders, :only => ["new","index","create"]
  resources :contacts, :only => ["new","index","create"]
  resources :itemcases, :only => ["index"] do
    collection do
      post :flip_item
      post :addto_cart
      post :remove_from_mycart
    end
  end
end
