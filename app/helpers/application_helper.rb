module ApplicationHelper
  def administrator?
    @current_person && @current_person.administrator?
  end
end
