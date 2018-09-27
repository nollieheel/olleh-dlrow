class PagesController < ApplicationController
  def home
    puts 'page home was invoked'
    @greeting = 'Hello World'
  end
end
