class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @orders = Order.all
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @order = Order.new
    @order.order_items.build
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    @order = Order.new(order_params)
    order_items = @order.order_items

      discounted_items = {}
      order_items.each do |oi|
        # check if already eligible for discount
        if discounted_items[oi.item.id]    # item_id_qty_mapping = {}
          t_qty = oi.quantity
          discount = Discount.find(discounted_items[oi.item.id].first)
          discount_multiplier = discounted_items[oi.item.id].last
          d_qty = discount.child_item_quantity * discount_multiplier
          d_qty = (d_qty >= t_qty) ? t_qty : d_qty
          r_oi_total = oi.item.price * t_qty
          d_oi_total = oi.item.price * d_qty * discount.discount_percent/100
          total = (r_oi_total - d_oi_total)
          tax = (oi.item.tax_category.tax_rate.to_f * total ) / 100
          oi.tax_value = tax
          oi.total_price = total + tax

          discounted_items.delete(oi.item.id)

        else
          discount = Discount.find_by(base_item_id: oi.item_id)
          if discount
            # check if we have desired qty of base item to give discount
              if oi.quantity >= discount.base_item_quantity
              # check for child item in the order_items and apply/flag for discount
              discount_multiplier = oi.quantity / discount.base_item_quantity
              discounted_items[discount.child_item_id] = [discount.id, discount_multiplier]
              # perform billing calcalation for base item
              # order item price calculation
              total = oi.item.price * oi.quantity
              tax = (oi.item.tax_category.tax_rate.to_f * total ) / 100
              oi.tax_value = tax
              oi.total_price = total + tax
            else
              #discount will not be applied
              # order item price calculation
              total = oi.item.price * oi.quantity
              tax = (oi.item.tax_category.tax_rate.to_f * total ) / 100
              oi.tax_value = tax
              oi.total_price = total + tax

            end
          else
            #discount will not be applied
            # order item price calculation
            total = oi.item.price * oi.quantity
            tax = (oi.item.tax_category.tax_rate.to_f * total ) / 100
            oi.tax_value = tax
            oi.total_price = total + tax
          end
        end
      end

      if discounted_items.present?
        discounted_items.each do |_child_item_id, discount_arr|
          discount_id, discount_multiplier = discount_arr
          discount = Discount.find(discount_id)
          order_item = @order.order_items.select{ |oi| oi.item_id == discount.child_item_id }.first
          if order_item
            t_qty = order_item.quantity
            d_qty = discount.child_item_quantity * discount_multiplier
            d_qty = (d_qty >= t_qty) ? t_qty : d_qty
            item = Item.find_by(id: discount.child_item_id)
            t_order_item_total = item.price * t_qty
            d_order_item_total = (item.price * d_qty * discount.discount_percent) / 100
            total = (t_order_item_total - d_order_item_total )
            tax = (item.tax_category.tax_rate.to_f * total ) / 100
            order_item.tax_value = tax
            order_item.total_price = total + tax
          end

          discounted_items.delete(discount.child_item_id)
        end
      end

    respond_to do |format|
      if @order.save
        OrderMailer.send_order_mail(@order).deliver_later!(wait: 5.minutes)
        format.html { redirect_to order_url(@order), notice: "Order was successfully Created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(order_items_attributes: OrderItem.attribute_names.map(&:to_sym).push(:destroy))
    end
end
