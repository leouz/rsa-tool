RsaTool::Application.routes.draw do
	root :to => 'main#index'
	post 'get_e_possibilities' => 'main#get_e_possibilities'
	post 'get_d' => 'main#get_d'
	post 'encrypt' => 'main#encrypt'
	post 'decrypt' => 'main#decrypt'
end
