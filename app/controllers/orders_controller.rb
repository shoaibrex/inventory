class OrdersController < ApplicationController
  #before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
    @members = Member.all
    @items = Item.all
    @active = Order.active?
    @expired = Order.expired?
  end

  def old
    @inactive = Order.inactive?
  end

  def renew
    @current_user = current_user
    @order = Order.find_by_id(params[:id])
    Order.renew(params[:id])
    redirect_to :root
    flash[:notice] = "Renewed for 7 days from now. Enjoy!"

    begin
      OrderMailer.delay.renew_order(@order, @current_user).deliver
    rescue Exception => e
    end
  end

  def disable
    borrowed_qty = Order.find_by_id(params[:id]).quantity.to_i
    @borrowed_item = Order.find_by_id(params[:id]).item
    @borrowed_item.increment!(:remaining_quantity, borrowed_qty)
    @current_user = current_user
    @order = Order.find_by_id(params[:id])
    Order.disable(params[:id])
    redirect_to :root
    flash[:notice] = "Item marked as returned. Thank you!"

    begin
      OrderMailer.delay.return_order(@order, @current_user).deliver
    rescue Exception => e
    end
  end

  def new
    @order = Order.new
    @items = Item.all
    @member = Member.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    if params[:item_id].present? && params[:item_id].count != 0 && params["order"]["member_id"] != nil
      @order = Order.create(member_id: params["order"]["member_id"])
      params[:item_id].count.times do |i|
        OrdersItem.create(order_id: @order.id, item_id: params[:item_id][i].to_i, quantity: params[:quantity][i].to_i, unit_price: params[:price][i].to_i, total_price: params[:price][i].to_i*params[:quantity][i].to_i)
      end
      redirect_to :root
      flash[:notice] = "Order Created Successfully"
    else
      flash[:alert] = 'Empty Order cannot be created '
      redirect_to :new_order
    end
  end

  def destroy
    borrowed_qty = @order.quantity.to_i
    @borrowed_item = @order.item
    @borrowed_item.increment!(:remaining_quantity, borrowed_qty)
    @current_user = current_user
    @order.destroy

    redirect_to orders_url, notice: 'Order was successfully destroyed.'
    begin
      OrderMailer.delay.cancel_order(@order, @current_user).deliver
    rescue Exception => e
    end
  end

  def print
    @order = Order.find(params[:order_id])
    @items = @order.orders_items
    @printer = Escpos::Printer.new
    @printer << Escpos::Helpers.title("Modern Enterprises")
    @printer << Escpos::Helpers.text("Main Lalazar Road - Sarwar Chowk")
    @printer << Escpos::Helpers.text("0302-5639014")
    @printer << Escpos::Helpers.u("Item  Quantity  Price  Total")
    @items.each do |it|
      st = it.item.name+"  "+it.quantity.to_s+"  "+it.unit_price.to_s+"  "+it.total_price.to_s
      @printer << Escpos::Helpers.u(st)
    end
    @printer << Escpos::Helpers.b("Total: "+@order.orders_items.sum(:total_price).to_s)
    @printer.to_escpos
    @printer.to_base64
    #debugger
    redirect_back(fallback_location: { action: "show", id: params[:order_id]})
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:quantity, :expire_at, :status, :item_id, :member_id)
    end
end
