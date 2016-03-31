class WelcomeController < ApplicationController
  def index
    params[:q][:cnpj_eq] = params[:q][:corporate_name_cont] unless params[:q].nil?
    @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
    @enterprises = @search.result
  end
end
