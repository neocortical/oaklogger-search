Oaklogger::Application.routes.draw do
  
  root 'search#home'
  
  get 'search' => 'search#search'

end
