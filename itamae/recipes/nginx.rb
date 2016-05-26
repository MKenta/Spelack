package 'nginx' do
  action :install
end

remote_file '/etc/nginx/nginx.conf' do
  source '../remote_files/nginx.conf'
end

remote_file '/etc/nginx/conf.d/Spelack.conf' do
  source '../remote_files/Spelack.conf'
end

service 'nginx' do
  action [:enable, :start]
end
