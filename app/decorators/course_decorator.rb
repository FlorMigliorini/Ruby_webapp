class CourseDecorator < Draper::Decorator
  delegate_all

 def test
  string = object.user.email
  last_char = "@"
  string.partition(last_char)[0..1].join.chop 
  end

  # def badge
  #   helpers.content_tag :span, "Adm", class: "badge badge-success" if admin?
  # end
  
  # def self.collection_decorator_class
  #   PaginatingDecoratorDecorator
  # end

  #  def published_at
  #   object.published_at.strftime("%A, %B %e")
  # end
end
