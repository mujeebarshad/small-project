# frozen_string_literal: true

module ModalHelper
  def remote_modal_link(text, url, classes: "", data: {})
    link_to text,
            url,
            remote: true,
            class: classes,
            data: modal_data_attributes.merge(data)
  end

  def modal_data_attributes
    {
      controller: "modal-remote-trigger",
      action: "modal-remote-trigger#show",
      modal_remote_trigger_id: "remote_modal"
    }
  end

  def modal_button(text, modal_id:, classes: "", data: {})
    button_tag text,
               type: :button,
               class: classes,
               data: {
                 controller: "modal-trigger",
                 action: "modal-trigger#show",
                 modal_trigger_id: modal_id
               }.merge(data)
  end
end
