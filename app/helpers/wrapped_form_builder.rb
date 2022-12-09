# frozen_string_literal: true

class WrappedFormBuilder < ActionView::Helpers::FormBuilder
  def field_wrapper(attribute, options)
    if options[:wrapper] != false
      @template.content_tag(:div,
                            class: form_group_classes(attribute, options)) do
        @template.concat label(attribute, options[:label], options[:label_options]) unless options[:label] == false
        @template.concat yield
        @template.concat get_errors(attribute, options)
      end
    else
      yield
    end
  end

  def label(method, text = nil, options = {}, &block)
    options = {} if options.nil?
    @template.content_tag :span, class: "form-group__label-wrapper" do
      @template.concat super
      @template.concat(@template.content_tag(:span, "(optional)", class: "u-ml-xxs")) if options[:optional]
      if options[:tooltip]
        @template.concat(
          @template.content_tag(:span, "?", class: "c-tooltip__trigger", data: {
                                  controller: "tooltip",
                                  tooltip_content: options[:tooltip],
                                  tooltip_arrow: "true"
                                })
        )
      end
    end
  end

  # List picked from form_helper source
  (field_helpers - %i[label check_box radio_button fields_for fields hidden_field file_field]).each do |field|
    define_method(field) do |attribute, options = {}|
      field_wrapper(attribute, options) do
        super(attribute, options)
      end
    end
  end

  %i[select country_select].each do |select|
    define_method(select) do |attribute, choices = nil, options = {}, html_options = {}|
      field_wrapper(attribute, options) do
        if html_options[:multiple]
          super(attribute, choices, options, html_options)
        else
          @template.component("select_box",
                              select: super(attribute, choices, options, html_options))
        end
      end
    end
  end

  # rubocop:disable Metrics/AbcSize
  def date_select(method, options = {}, html_options = {})
    date_time_selector = ActionView::Helpers::DateTimeSelector.new(@object.send(method),
                                                                   options.merge(
                                                                     prefix: @object_name,
                                                                     field_name: method.to_s,
                                                                     include_position: true
                                                                   ),
                                                                   html_options)

    field_wrapper(method, options) do
      @template.capture do
        @template.concat(@template.content_tag(:div, class: "c-date-select #{options&.dig(:html_options, :classes)}") do
          @template.concat(@template.component("select_box", select: date_time_selector.select_day))
          @template.concat(@template.component("select_box", select: date_time_selector.select_month))
          @template.concat(@template.component("select_box", select: date_time_selector.select_year))
        end)
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def form_group_classes(attribute, options = {})
    classes = ["form-group"]
    classes << "form-group--with-error" if errors?(attribute)
    classes << options[:wrapper_classes] if options[:wrapper_classes].present?
    classes.join(" ")
  end

  def errors?(attribute)
    @object&.errors.try(:[], attribute)&.present?
  end

  def get_errors(attribute, options = {})
    return unless errors?(attribute)

    @template.content_tag(:p, class: "form-group__error-message") do
      (if options.dig(:errors, :skip_attribute) == true
         ""
       else
         @object&.class&.human_attribute_name(attribute)&.to_s
       end) + " " + @object&.errors.try(:[], attribute)&.join(", ")&.to_s
    end
  end
end
