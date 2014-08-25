class ChaptersController < ApplicationController
  expose(:chapter) { Chapter.new(params[:path]) }
  expose(:next_chapter) { chapter.next }
  expose(:previous) { chapter.previous }
  expose(:text) { chapter.text }
  expose(:contact)
end
