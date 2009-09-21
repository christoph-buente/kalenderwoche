ActionController::Routing::Routes.draw do |map|
  
  map.root      :controller => 'week', :action => 'index'
  map.resources :week, :as => 'woche', :only => [:index, :show]
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
