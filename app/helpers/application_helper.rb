module ApplicationHelper
  def break_text_after_n_characters(text, n)
    text.scan(/.{1,#{n}}/).join('<br/>').html_safe
  end
end
