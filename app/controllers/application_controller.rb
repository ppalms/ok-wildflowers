class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['APP_USER'], password: ENV['APP_PASSWORD']
end
