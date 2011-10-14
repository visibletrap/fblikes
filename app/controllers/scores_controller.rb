class ScoresController < ApplicationController
  def main
    @companies = Company.all
  end
end
