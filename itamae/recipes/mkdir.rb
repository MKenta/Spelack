execute 'sudo mkdir -p /var/www/' do
  not_if 'test -d /var/www'
end

execute 'sudo chown -R spelack-dev /var/www' do
end
