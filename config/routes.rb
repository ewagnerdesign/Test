ActionController::Routing::Routes.draw do |map|

  # for javascript plugin http://github.com/sustainablecode/javascript_named_routes
  map.javascript_named_routes

  map.dashboard 'dashboard', :controller => "dashboard", :action => "index"

  map.resources :visits

  map.resources :subjects do |subject|
    subject.resources :cumcrfs, :collection => { :list => :get }
  end

  map.resources :monitor_views, :member => { :edit_fields => :get, :update_fields => :put, :monitored => :put }

  map.resources :queries, :member => { :close => :put, :get_form_instances_field_values => :get }, :collection => { :list => :get } do |query|
    query.resources :comments, :controller => "query_comments"
  end

  map.resources :ecrfs
  map.resources :forms
  map.resources :study_arms
  map.resources :sites
  
  map.resource :fd, :controller => "fd", :collection => { :get_domains => :get, :index => :get }

  map.admin 'admin', :controller => "admin", :action => "index"
  map.namespace(:admin) do |admin|
    admin.resources :users, :collection => { :logins => :get}, :member => {:unlock => :get } do |user|
      user.resources :roles, :controller => "user_system_roles"
      user.resources :study_roles, :controller => "user_study_roles", :member => { :add_sites => :get, :assign_sites => :put }
    end
    admin.resources :studies, :controller => "admin_studies" do |study|
      study.resources :contacts, :controller => "study_contacts", :member => { :remove => :delete}, :collection => {:add => :get, :enroll => :put }
      study.resources :study_arms, :member => { :rename => :put }
      study.resources :sites, :controller => "study_sites", :member => { :remove => :delete}, :collection => {:add => :get, :enroll => :put } do |site|
        site.resources :contacts, :controller => "study_site_contacts", :member => { :remove => :delete}, :collection => {:add => :get, :enroll => :put }
      end
      study.resources :visits,  :controller => "study_visits"
      study.resources :forms, :controller => "study_forms" do |study_form|
        study_form.resources :form_versions, :collection => { :publish => :post}
      end
      study.resources :crfs, :controller => "study_cumulative_crfs"
    end
    admin.resources :therapeutic_areas, :controller => "therapeutic_areas"
    admin.resources :sites, :controller => "admin_sites" do |site|
      site.resources :contacts, :controller => "site_contacts", :member => { :remove => :delete}, :collection => {:add => :get, :enroll => :put}
    end
    admin.resources :sdtm_categories do |sdtm_category|
      sdtm_category.resources :sdtm_answers
    end
    admin.resources :forms, :collection => { :preview => :post, :preview_fv => :get}
    admin.resources :domains do |domain|
      domain.resources :cdash_questions
    end
    admin.resources :changes, :controller => "changes"
    admin.resources :roles
    admin.resources :permissions
    admin.resources :policies, :collection => { :set => :put, :expire_all_passwords => :post }
  end

  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users, :member => { :update_password => :put, :change_password=>:get }

  map.resources :site_users,
                :member=>{ :roles=>:get, :update_roles=>:post, :destroy_from_study=>:delete },
                :path_names => { :update_roles => 'roles' }
#                :as=> "contacts/:study_id",
#                :defaults=>{ :study_id=>nil }

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"
  map.root :controller => "dashboard"
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
