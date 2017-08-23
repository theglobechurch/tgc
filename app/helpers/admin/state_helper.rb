module Admin::StateHelper

  def btn_state_change(name, record, state, html_options = {})
    model = record.class.to_s.underscore

    button_to(
      name,
      [:admin, record],
      method: :patch,
      params: {
        :"#{model}[state_event]" => state,
      },
      **html_options
    )
  end

end
