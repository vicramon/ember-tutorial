class HomeController < ApplicationController
  expose(:contact)

  def all
    @chapters = Chapter.all_chapters
  end

end
