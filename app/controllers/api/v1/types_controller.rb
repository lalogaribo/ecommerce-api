class Api::V1::TypesController < ApplicationController
  before_action :set_type, only: %i[show]

  def index
    types = Type.all
    render json: { data: types }
  end

  def show
    render json: { data: TypeSerializer.new(@type) }
  end

  private

    def set_type
      @type = Type.find(params[:id])
    end
end