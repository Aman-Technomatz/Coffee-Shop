module OrdersHelper
  def link_to_add_order_item(name, order_form, association)
    new_object = order_form.object.send(association).klass.new
    id = new_object.object_id
    fields = order_form.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", order_form: builder)
    end
    link_to(name, 'add item', class: "add_order_item", data: {id: id, fields: fields.gsub("\n", ""), controller: 'user-modal'})
  end
end
