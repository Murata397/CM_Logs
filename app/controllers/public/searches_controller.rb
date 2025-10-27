class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method)
    elsif @model == 'maintenance'
      @records = Maintenance.search_for(@content, @method)
    else
      @records = Car.search_for(@content, @method)
    end
  end
end
