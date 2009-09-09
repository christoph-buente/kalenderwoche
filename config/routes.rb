ActionController::Routing::Routes.draw do |map|
  
  map.root      :controller => 'homes', :action => 'index', :format => :ics
  map.resources :homes, :as => 'kalenderwochen', :only => [:index, :show]
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
