class OptionsController < ApplicationController
  def edit
    @option = Option.find_by(key: params[:key])
  end

  def update
    code = params[:code]
    if code_is_valid?(code)
      @option = Option.find(params[:id])
      if @option.update(option_params)
        render json: "All is well."
      else
        render json: "Umm.."
      end
    else
      render json: "Nope."
    end
  end

  private

  def option_params
    params.require(:option).permit(:key, :value)
  end

  def code_is_valid?(code)
    time = Time.zone.now
    day = time.day.to_s
    key_hour = get_key_hour(time.hour).to_s
    key = "57"+day+key_hour

    code == key ? true : false
  end

  def get_key_hour(hour)
    if hour.between?(0,5)
      1
    elsif hour.between?(6,11)
      2
    elsif hour.between?(12,17)
      3
    else
      4
    end
  end
end