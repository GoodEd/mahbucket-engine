module Mahbucket
  # Tag controller
  class TagsController < ApplicationController
    # GET /tags
    # GET /tags.json
    def index
      @tags = ActsAsTaggableOn::Tag.all.order( :name )
      render layout: 'nt_layout'
    end

    def tag_cloud
      @tags = Item.tag_counts_on( :customs )
      render layout: 'nt_layout'
    end

    # GET /tags/1
    # GET /tags/1.json
    def show
      @tag = ActsAsTaggableOn::Tag.find( params[:id] )
      render layout: 'nt_layout'
    end
  end
end
