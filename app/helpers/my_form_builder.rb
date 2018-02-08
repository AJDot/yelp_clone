class MyFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    errors = object.errors[method.to_sym]
    add_error_class_to_options!(method, options, class: 'error')
    if errors
      text += " <span class=\"error\">#{errors.first}</span>"
    end
    super(method, text.html_safe, options, &block)
  end

  def text_field(method, options = {})
    errors = object.errors[method.to_sym]
    if !errors.empty?
      new_options = { class: 'error' }
      options = options.merge!(new_options) do |key, oldval, newval|
        if oldval && key == :class
          "#{oldval} #{newval}"
        else
          newval
        end
      end
    end
    super(method, options)
  end

  def text_field(method, options = {})
    add_error_class_to_options!(method, options, class: 'error')
    super(method, options)
  end

  def email_field(method, options = {})
    add_error_class_to_options!(method, options, class: 'error')
    super(method, options)
  end

  def password_field(method, options = {})
    add_error_class_to_options!(method, options, class: 'error')
    super(method, options)
  end

  private

  def add_error_class_to_options!(method, options, classes)
    errors = object.errors[method.to_sym]
    if !errors.empty?
      options.merge!(classes) do |key, oldval, newval|
        if oldval && key == :class
          "#{oldval} #{newval}"
        else
          newval
        end
      end
    end
  end
end
