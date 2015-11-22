class StaticPagesController < ApplicationController
  before_action :authenticate_admin!

  def settings

  end
end
