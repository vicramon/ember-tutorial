class Chapter

  def self.all
    [
      'Introduction',
      'Hello World',
      'The Ember Object',
      'Routing in Ember',
      'Ember Object Flow',
      'Ember Route',
      'Ember Controller',
      'Ember View',
      'Ember Template',
      'Our App',
      'Creating the Rails API',
      'Modeling Leads',
      'Listing Leads',
      'Showing Leads',
      'Updating Leads',
      'Deleting Leads',
      'Conclusion'
    ]
  end

  attr_reader :name

  def initialize(name)
    @name = name.titleize.sub('In', 'in')
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
