class Components::Modal < ApplicationView
  def template(&)
    div(x_data: true, &)
  end

  def body
    dialog(x_ref: "modal") do
      button("@click" => "$refs.modal.close()") { "X" }
      yield
    end
  end

  def open_button(&)
    button("@click" => "$refs.modal.showModal()", &)
  end
end
