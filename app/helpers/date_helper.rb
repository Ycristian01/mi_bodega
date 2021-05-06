module DateHelper 
  def to_date(date)
      DateTime.strptime(date,'%s').strftime("%B %d, %Y")
  end
end