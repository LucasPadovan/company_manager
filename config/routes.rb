CompanyManager::Application.routes.draw do
  resources :orders do
    resources :items, only: [:new, :create, :destroy]
  end

  resources :products, :custom_products, :raw_products, controller: :products do
    resources :purchase_interests, only: [:new, :create, :destroy]
    resources :sale_interests, only: [:new, :create, :destroy]
    member do
      get :prices_list
    end
    resources :recipes do
      resources :components
    end
  end

  resources :interests, only: :show do
    member do
      resources :prices
    end
  end

  resources :monthly_movements, except: [:destroy] do
    resources :sale_invoices do
      collection do
        post :generate_csv
      end
    end
    resources :purchase_invoices do
      collection do
        post :generate_csv
      end
    end
    member do
      put :set_as_send
      put :set_as_finalized
    end
  end

  resources :firms do
    resources :contacts, only: [:new, :create, :edit, :update, :destroy]
    resources :purchase_interests, only: [:new, :create, :destroy]
    resources :sale_interests, only: [:new, :create, :destroy]
    member do
      get :prices_list
    end
  end

  devise_for :users
  
  resources :users do
    member do
      get :edit_profile
      put :update_profile
    end
  end
  
  root to: redirect('/users/sign_in')
end
