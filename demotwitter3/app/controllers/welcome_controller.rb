class WelcomeController < ApplicationController
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 3)
  	@post = Post.new
  end
end
