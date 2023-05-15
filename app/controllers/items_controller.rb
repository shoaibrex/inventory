class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :update_stock, :stock]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    params[:item][:remaining_quantity] = params[:item][:quantity]
    @item = Item.new(item_params)
    if @item.save
      @item.add_keywords(params[:keywords])
      redirect_to :new_item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to :root, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  def update_stock
  end

  def stock
    old_stock = @item.quantity
    if params[:act].present? and params[:act] == "1"
      @item.quantity += params[:number].to_i
      Log.create(item_id: @item.id, old_stock: old_stock, new_stock: @item.quantity, action: "add")
    else
      @item.quantity -= params[:number].to_i
      Log.create(item_id: @item.id, old_stock: old_stock, new_stock: @item.quantity, action: "remove")
    end
    @item.save
    redirect_to :items
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :category, :quantity, :description, :remaining_quantity, :category_id)
  end
end
