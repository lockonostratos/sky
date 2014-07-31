class TempOrderDetailsController < ApplicationController
  before_action :set_temp_order_detail, only: [:show, :edit, :update, :destroy]

  # GET /temp_order_details
  # GET /temp_order_details.json
  def index
    @temp_order_details = TempOrderDetail.all
    respond_to do |format|
      format.html { render layout: "account" }
      format.json { render :json => @temp_order_details, root: false }
    end
  end

  # GET /temp_order_details/1
  # GET /temp_order_details/1.json
  def show
    respond_to do |format|
      format.html { render layout: "account" }
      format.json { render :json => @temp_order_detail, root: false }
    end
  end
  def current_temp_order_details
    @temp_orders = TempOrderDetail.where(order_id: params[:order_id])
    render json: @temp_orders, :root => false
  end

  # GET /temp_order_details/new
  def new
    @temp_order_detail = TempOrderDetail.new
  end

  # GET /temp_order_details/1/edit
  def edit
  end

  # POST /temp_order_details
  # POST /temp_order_details.json
  def create
    @temp_order_detail = TempOrderDetail.new(temp_order_detail_params)

    respond_to do |format|
      if @temp_order_detail.save
        format.html { redirect_to @temp_order_detail, notice: 'Temp order detail was successfully created.' }
        format.json { render :json => @temp_order_detail, root: false, status: :created, location: @temp_order_detail }
      else
        format.html { render action: 'new' }
        format.json { render json: @temp_order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temp_order_details/1
  # PATCH/PUT /temp_order_details/1.json
  def update
    respond_to do |format|
      if @temp_order_detail.update(temp_order_detail_params)
        format.html { redirect_to @temp_order_detail, notice: 'Temp order detail was successfully updated.' }
        format.json { render :json => @temp_order_detail, root: false }
      else
        format.html { render action: 'edit' }
        format.json { render json: @temp_order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_order_details/1
  # DELETE /temp_order_details/1.json
  def destroy
    @temp_order_detail.destroy
    respond_to do |format|
      format.html { redirect_to temp_order_details_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_order_detail
      @temp_order_detail = TempOrderDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def temp_order_detail_params
      params.require(:temp_order_detail).permit(:order_id, :product_summary_id, :product_code, :skull_id, :warehouse_id, :quality, :price, :discount_cash, :discount_percent, :temp_discount_percent, :total_amount)
    end
end
