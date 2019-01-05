Rails.application.routes.draw do

	root 'users#welcome'
	resources :users do
		collection do
			  get 'welcome'
			  post 'register'
			  post 'login'
			  get 'edit'
			  get 'delete'
			  post 'create',as:'creation'
			  post 'validate_login'
			  post 'logout'
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
