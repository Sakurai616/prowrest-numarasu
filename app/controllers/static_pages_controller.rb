class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def about; end

  def privacy; end

  def term; end
end
