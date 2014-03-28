class ChaptersController < ApplicationController
  expose(:chapter) { Chapter.new(params[:path]) }
  expose(:next_chapter) { chapter.next }
  expose(:previous) { chapter.previous }
  expose(:text) { chapter.text }

=begin
  - router
  - route, controller, view, template
Chapter 4: Planning the Application
Chapter 5: Modeling Data
Chapter 6: Sign In
  - best way to do this?
Chapter 7: Listing
Chapter 8: Creating New
  - validations
Chapter 9: Editing
Chapter 10: Deleting
=end

end
