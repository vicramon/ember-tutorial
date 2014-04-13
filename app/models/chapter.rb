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
      'Creating the Layout',
      'Modeling Leads',
      'Listing Leads',
      'Showing a Lead',
      'Updating a Lead',
      'Deleting a Lead',
      'Searching Leads',
      'Conclusion'
    ]
  end

  attr_reader :name

  def initialize(name)
    @name = better_titleize(name)
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

  private

  def index
    @index ||= Chapter.all.index(name)
  end

  def better_titleize(name)
    name.titleize.tap do |name|
      TITLE_WORDS.each do |pattern|
        name.sub!(pattern[:word], pattern[:replacement])
      end
    end
  end

  TITLE_WORDS = [
    { word: ' In', replacement: ' in' },
    { word: ' Api', replacement: ' API' },
    { word: ' The', replacement: ' the' },
    { word: ' A', replacement: ' a' }
  ]

end
