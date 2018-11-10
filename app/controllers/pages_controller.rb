class PagesController < ApplicationController
  def home
    puts 'page home was invoked'
    #@greeting = 'Hello World'
    @greeting = ENV['MESSAGE']
  end
end
