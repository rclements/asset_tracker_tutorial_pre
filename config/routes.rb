AssetTrackerTutorial::Application.routes.draw do
  root :to => "dashboard/base#index"

  devise_for :users do
    get 'login', :to => 'devise/sessions#new'
    post 'login', :to => 'devise/sessions#create'
    get 'logout', :to => 'devise/sessions#destroy'
  end

  namespace :admin do
    resources :invoices, :as => :invoice
    resources :payrolls, :as => :payroll
    resources :users
    resources :projects
    resources :weekly_time_report
  end
  get '/admin', :controller => "admin/base", :action => "index"

  resources :clients do
    resources :comments
    resources :projects
  end

  resources :projects do
    resources :comments
    resources :tickets
  end

  resources :tickets do
    resources :comments
    resources :work_units
  end

  resources :work_units do
    resources :comments
  end

  resources :users do
    member do
      put :change_password
    end
  end

  resources :comments

  namespace :dashboard do
    resources :base do
      collection do
        get :recent_work
      end
    end
    resources :work_units
  end
  get '/dashboard', :controller => "dashboard/base", :action => "index"
  get '/dashboard/client', :controller => "dashboard/base", :action => "client"
  get '/dashboard/project', :controller => "dashboard/base", :action => "project"
  get '/dashboard/recent_work', :controller => "dashboard/base", :action => "recent_work"

  namespace :api do
    namespace :v1 do
      resources :clients
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
