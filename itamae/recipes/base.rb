%w(install_package yum_update ruby_build nvm nginx redis mkdir).each do |resource|
  include_recipe "./#{resource}.rb"
end
