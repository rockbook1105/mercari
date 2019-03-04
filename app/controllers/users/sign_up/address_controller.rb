class Users::SignUp::AddressController < ApplicationController
  def new
    @user = User.find(1)
    @address = @user.build_address
  end

  def create
    @user = User.find(1)
    @address = @user.build_address(address_params)
    if @address.save
      redirect_to users_sign_up_payment_methods_path
    else
      render :index
    end
  end

  private

  def address_params
    params.require(:address).permit(
      :family_name,
      :first_name,
      :family_name_kana,
      :first_name_kana,
      :zipcode,
      :prefecture,
      :city,
      :block_number,
      :building_name,
      :phone_number
    )
  end
end
