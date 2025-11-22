class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
    def index
        @users = User.with_deleted.all
    end
end
