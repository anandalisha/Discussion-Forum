class SearchController < ApplicationController
    def index
      @query = Discussion.ransack(params[:q])
      @discussions = @query.result(distinct: true)
    end
end
