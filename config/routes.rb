CompanyManager::Application.routes.draw do
  resources :products do
    resources :sale_histories, only: [:index, :show, :new, :create]
    resources :product_histories, only: [:index, :show, :new, :create]
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
