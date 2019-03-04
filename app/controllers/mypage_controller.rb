class MypageController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
  end

  def notification
  end

  def todo
  end
end
