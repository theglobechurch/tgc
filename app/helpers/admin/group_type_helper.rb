module Admin::GroupTypeHelper
  def group_type_picker(form, field, exclude = [], html_options = {})
    display_types = GroupingType.all.reject do |t|
      exclude.include?(t)
    end

    content_tag(:div, html_options) do

      display_types.each do |rt|
        concat(content_tag(:label, class: 'form__label form__label--radio') do
          concat(
            form.radio_button(field, rt)
          )
          concat(
            content_tag(:span, rt)
          )
        end)
      end

    end
  end
end
