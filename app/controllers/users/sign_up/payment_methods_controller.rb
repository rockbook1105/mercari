class Users::SignUp::PaymentMethodsController < ApplicationController
  def new
    @payjp_card_form = PayjpCardForm.new
    @exp_month_options = [*1..12].map { |i| format("%02d", i) }
    @exp_year_options = [*Time.current.year..Time.current.year + 10]
  end

  def create
    @payjp_card_form = PayjpCardForm.new(payjp_card_form_params)
    if @payjp_card_form.save(current_user)
      redirect_to users_sign_up_done_index_path
    else
      redirect_back fallback_location: { controller: "Users::SignUp::PaymentMethodsController", action: "new"}
    end
  end

  private

  def payjp_card_form_params
    params.require(:payjp_card_form).permit(:number, :exp_month, :exp_year, :cvc)
  end
end
