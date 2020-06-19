server '18.178.53.19', user: 'myuser', roles: %w{app db web} 

set :ssh_options, keys: '~/.ssh/id_rsa'