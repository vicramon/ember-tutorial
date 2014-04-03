class Chapter

  def self.all
    [
      'Introduction',
      'Hello World',
      'Ember Concepts',
      'Our App',
    ]
  end

  attr_reader :name

  def initialize(name)
    @name = name.titleize
  end

  def text
    File.new("app/views/chapters/#{name.parameterize}.md").read
  end

  def next
    Chapter.all[index + 1] if index < Chapter.all.length - 1
  end

  def previous
    Chapter.all[index - 1] if index > 0
  end

  def index
    @index ||= Chapter.all.index(name)
  end

end
