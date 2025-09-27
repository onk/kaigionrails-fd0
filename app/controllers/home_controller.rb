class HomeController < ApplicationController
  def index
    render plain: "Hello, #{params[:name] || "World"}!"
  end
end
