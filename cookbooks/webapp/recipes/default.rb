windows_feature 'IIS-WebServerRole' do
  install_method :windows_feature_dism
  all true
  action :install
end

service 'w3svc' do
  action %i(enable start)
end

template 'C:/inetpub/wwwroot/index.html' do
  source 'index.html.erb'
  variables(version: node['webapp']['version'])
end
