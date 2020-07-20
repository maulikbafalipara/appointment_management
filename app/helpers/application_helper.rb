module ApplicationHelper
  def speciality_list
    Speciality.all.map{ |s| [s.title, s.id] }
  end

  def human_readable_datetime(datetime)
    datetime.strftime("%B %e, %Y at %I:%M %p") rescue ''
  end
end
