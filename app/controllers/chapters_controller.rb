class ChaptersController < ApplicationController

  def show
    @text = File.new("app/views/chapters/#{params[:path]}.md").read
  end
end
