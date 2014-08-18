class StaticPagesController < ApplicationController
  def home
    redirect_to current_user if current_user
  end

  def help
  end

  def about
  end

  def contact
  end

  def other
  end
end
