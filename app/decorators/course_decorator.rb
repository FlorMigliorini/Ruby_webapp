class CourseDecorator < Draper::Decorator
  delegate_all

 def display
  string = object.user.email
  last_char = "@"
  string.partition(last_char)[0..1].join.chop 
  end

  def adm_badge
    helpers.content_tag :span, "Adm", class: "badge badge-success" if admin?
  end

  def mod_badge
    helpers.content_tag :span, "Mod", class: "badge badge-primary" if moderator?
  end

  def full_title
    "#{title}"
  end
  
  def self.collection_decorator_class
    PaginatingDecoratorDecorator
  end

end
