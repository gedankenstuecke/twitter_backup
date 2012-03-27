class SearchController < ApplicationController

  def search_type(type)
	  return type.solr_search { |p| p.keywords params[:search] }
  end

  def search
	  @tweets = search_type Tweet
    @users = search_type User
    @places = search_type Place
  end
 

end
