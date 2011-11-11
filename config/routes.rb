Agg::Application.routes.draw do
  root :to => 'feeds#index'

  match 'feedbacks' => 'feedbacks#create', :as => :feedback
  get 'feedbacks/new' => 'feedbacks#new', :as => :new_feedback

  get 'coupons' => 'coupons#index', :as => :coupons
  get 'coupons/:id.:format' => 'coupons#local', :as => :local_coupons

  get '/about' => 'feeds#about', :as => :about
  get '/faq' => 'feeds#faq', :as => :faq
  get '/old/' => 'feeds#yesterday', :as => :yesterday
  match '/small/' => 'feeds#small', :as => :small
  get '/advertisers/' => 'feeds#advertisers', :as => :advertisers
  match '/signup/' => 'signups#index', :as => :signups
  match '/signup/thanks' => 'signups#thanks', :as => :signup_thanks

  get '/backlog' => 'feeds#backlog'
  get '/cronlog' => 'feeds#cronlog'
  get '/djlog' => 'feeds#djlog'
  get '/touch/:id' => 'touch#perform'
end
