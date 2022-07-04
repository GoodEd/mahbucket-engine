module Mahbucket
  class ItemsController < ApplicationController
    before_action :set_item, only: %i[ show edit update destroy ]
  
    # GET /items
    # GET /items.json
    def index
      @items = Item.where(user_id: @current_user.id)
        .order(created_at: :desc)
        .paginate(page: params[:page], per_page: 30)

      render layout: 'nt_layout'
    end
  
    # GET /items/1
    # GET /items/1.json
    def show
      render layout: 'nt_layout'
    end
  
    # GET /items/new
    def new
      @item = Item.new
      render layout: 'nt_layout'
    end
  
    # POST /items
    # POST /items.json
    def create
      @item = Item.new(item_params.merge(user_id: @current_user.id))
  
      respond_to do |format|
        if @item.save
          format.html { redirect_to @item, notice: 'Item was created.', layout: 'nt_layout'}
          format.json { render :show, status: :created, location: @item }
        else
          format.html { render :new, layout: 'nt_layout' }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # GET /items/1/edit
    def edit
      render layout: 'nt_layout'
    end
  
    # PATCH/PUT /items/1
    # PATCH/PUT /items/1.json
    def update
      respond_to do |format|
        if @item.update(item_params)
          format.html { redirect_to @item, notice: 'Item was updated.' }
          format.json { render :show, status: :ok, location: @item }
        else
          format.html { render :edit }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /items/1
    # DELETE /items/1.json
    def destroy
      @item.destroy
      respond_to do |format|
        format.html { redirect_to items_url, notice: 'Item was deleted.' }
        format.json { head :no_content }
      end
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
  
    # Never trust parameters from the Internet, only allow the whitelist through
    def item_params
      params.require( :item ).permit( :file, :tag_list )
    end
  end
  
end