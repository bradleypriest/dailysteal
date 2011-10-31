Agg::Application.routes.draw do
  root :to => 'feeds#index'

  match 'feedbacks' => 'feedbacks#create', :as => :feedback
  match 'feedbacks/new' => 'feedbacks#new', :as => :new_feedback

  match 'coupons' => 'coupons#index', :as => :coupons
  match 'coupons/:id.:format' => 'coupons#local', :as => :local_coupons

  match '/about' => 'feeds#about', :as => :about
  match '/faq' => 'feeds#faq', :as => :faq
  match '/old/' => 'feeds#yesterday', :as => :yesterday
  match '/small/' => 'feeds#small', :as => :small
  match '/advertisers/' => 'feeds#advertisers', :as => :advertisers
  match '/signup/' => 'signups#index', :as => :signups
  match '/signup/thanks' => 'signups#thanks', :as => :signup_thanks

  match '/backlog' => 'feeds#backlog'
end
