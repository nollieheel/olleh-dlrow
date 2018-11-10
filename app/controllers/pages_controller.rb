class PagesController < ApplicationController
  def home
    puts 'page home was invoked'
    @greeting = ENV['MESSAGE'] || 'The quick brown fox jumped over the lazy dog'
  end
end
