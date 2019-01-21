Rails.application.routes.draw do


  mount Ckeditor::Engine => '/ckeditor'
	root 'users#welcome'
	resources :users do
		collection do
			  get 'welcome'
			  post 'register'
			  post 'login'
			  post 'my_profile'
			  post 'update'
			  get 'delete'
			  post 'create',as:'creation'
			  post 'validate_login'
			  post 'logout'
		end
	end

	resources :blogs do
		collection do
			  get 'new'
			  get 'edit'
			  get 'show'
			  post 'create'
			  post 'update'
		end
	end

	resources :cafes do
		collection do
			  post 'new'
			  post 'create'
			  post 'edit'
			  post 'update'
			  post 'delete'
			  post 'global_cafes'
			  post 'my_cafes'
			  post 'membership_cafes'
			  post 'tasks'
			  get 'show'
			  post 'show'
			  post 'show_all_members'
		end
	end

	resources :invitations do
		collection do
			  post 'new_request_log'
			  post 'view_requests'
			  post 'take_action'
		end
	end

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
