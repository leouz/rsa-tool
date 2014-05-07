RsaTool::Application.routes.draw do
	root :to => 'ecc#index'
  
  get 'rsa' => 'rsa#index'
	post 'rsa/get_e_possibilities' => 'rsa#get_e_possibilities'
	post 'rsa/get_d' => 'rsa#get_d'
	post 'rsa/encrypt' => 'rsa#encrypt'
	post 'rsa/decrypt' => 'rsa#decrypt'

  get 'ecc' => 'ecc#index'
  post 'ecc/eliptic-groups' => 'ecc#eliptic_groups'  
  post 'ecc/sum' => 'ecc#sum' 
  post 'ecc/diff' => 'ecc#diff'  
  post 'ecc/product' => 'ecc#product'
end
