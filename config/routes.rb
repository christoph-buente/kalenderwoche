ActionController::Routing::Routes.draw do |map|
  
  map.root      :controller => 'week', :action => 'index'
  map.resources :year, :has_many => :week
  map.resources :week
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
