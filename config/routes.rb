BeadsKoolbzComAu::Application.routes.draw do
  devise_for :flyers, :controllers => { :omniauth_callbacks => "flyers/omniauth_callbacks" }
  root :to => 'showcases#index'
  resources :showcases, :only => ["index"]
  resources :orders, :only => ["new","index","create"] do
    collection do
      post :confirm_order
    end
  end
  resources :images, :only => ["create","destroy"]
  resources :contacts, :only => ["new","index","create"]
  resources :items, :only => ["new","index","create","update"] do
    collection do
      post :tap_open_status
      post :tap_main
    end
  end
  resources :itemcases, :only => ["index"] do
    collection do
      post :flip_item
      post :addto_cart
      post :remove_from_mycart
      post :clear_mycart
      post :order_count
    end
  end
end
