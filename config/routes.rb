ActionController::Routing::Routes.draw do |map|

  map.feedback 'feedbacks', :controller => 'feedbacks', :action => 'create'
  map.new_feedback 'feedbacks/new', :controller => 'feedbacks', :action => 'new'
  #map.mailer 'mailer', :controller => 'mailer', :action => 'index'
 # map.resources :feeds, :as => 'deals', :only => [:index, :show] #,do |feeds|
  map.coupons 'coupons', :controller => 'coupons', :action => 'index'
  
  map.coupons 'coupons/:id.:format', :controller => 'coupons', :action => 'local'
  #  feeds.resources :signups
 # end
  
  # map.resources :signups

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
 map.root :controller => "feeds"
 #map.help '/help', :controller => 'feeds', :action => 'help'
 map.about '/about', :controller => 'feeds', :action => 'about'
 map.faq '/faq', :controller => 'feeds', :action => 'faq'
 map.yesterday '/old/', :controller => 'feeds', :action => 'yesterday'
 map.small '/small/', :controller => 'feeds', :action => 'small'
 #map.mailer '/mailer/', :controller => 'mailer', :action => 'index'
 #map.signup '/signup/', :controller => 'signups', :action => 'index'
 map.advertisers '/advertisers/', :controller => 'feeds', :action => 'advertisers'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.

  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
