class OrderMailer < ApplicationMailer
  def send_order_mail(order)
    @order = order

    mail(to:"example@gamil.com", from:"example@gamil.com", subject:"#{@order.id}", message:"hello")
  end
end
