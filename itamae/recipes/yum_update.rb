execute 'yum clean all' do
  user 'root'
end

execute 'yum update -y' do
  user 'root'
end
