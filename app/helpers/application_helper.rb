module ApplicationHelper
  def my_form_for(record, options = {}, &proc)
    form_for(record, options.merge!({builder: MyFormBuilder}), &proc)
  end

  def options_for_business_reviews(selected = nil)
    options_for_select(
      [5, 4, 3, 2, 1].map do |number|
        [pluralize(number, "Star"), number]
      end,
      selected
    )
  end

  def date_from(datetime)
    datetime.strftime('%b %e, %Y')
  end
end
