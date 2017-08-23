module Admin::ResourceTypeHelper
  def resource_type_picker(f, field, exclude = [], html_options = {})
    display_types = f.object.class.available_resource_types.reject do |t|
      exclude.include?(t)
    end

    btn_cls = ['m-admin-resource-type-picker__button',
               'js-resource-type-button']

    content_tag(:div, html_options) do

      concat(content_tag(:div, class: 'm-admin-resource-type-picker') do
        display_types.each do |rt|
          concat(
            button_tag(rt,
                       type: 'button',
                       class: btn_cls.join(" "),
                       data: {value: rt})
          )
        end
      end)

      concat(f.hidden_field(field, class: 'form__input js-resource-type-field'))

    end
  end
end
