class HomeController < ApplicationController

  def all
    @chapters = Chapter.all_chapters
  end

end
