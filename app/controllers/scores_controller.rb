include Spawn

class ScoresController < ApplicationController
  def main
    @companies = Company.all
  end
  def a
    spawn(:method => :thread) do
      puts "Hello world"
      (1..10).each do |i|
        puts "Hello world"
        sleep 1
      end
    end
    render :nothing => true
  end
end
