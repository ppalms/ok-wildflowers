class ApplicationController < ActionController::Base
  # TODO: handle basic auth when testing
  http_basic_authenticate_with name: ENV['APP_USER'], password: ENV['APP_PASSWORD']
end
