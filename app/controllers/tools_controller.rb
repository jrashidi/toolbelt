class ToolsController < ApplicationController
  before_action :set_tool, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @tools = current_user.tools

  end

  def show
    @photos = @tool.photos 
  end

  def new
    @tool = current_user.tools.build 
  end

  def create
    @tool = current_user.tools.build(tool_params)

    if @tool.save 
      if params[:images] 
        params[:images].each do |image|
        @tool.photos.create(image: image)
      end 
    end 
      @photos = @tool.photos
      redirect_to edit_tool_path(@tool), notice: "Saved Successfully"
    else 
      render :new 
    end 
  end 

  def edit
    if current_user.id == @tool.user.id 
      @photos = @tool.photos
    else 
      redirect_to root_path, notice: "You do not have permission to edit photos"
    end
  end 

  def update
    if @tool.update(tool_params)
      if params[:images] 
        params[:images].each do |image|
        @tool.photos.create(image: image)
      end 
    end 
      redirect_to edit_tool_path(@tool), notice: "Updated Successfully"
    else 
      render :edit 
    end 
  end

  private 
    def set_tool
      @tool = Tool.find(params[:id])
    end

    def tool_params
      params.require(:tool).permit(:tool_type, :model_type, :listing_name, :summary, :address, 
                                  :extra_tools, :dimensions, :voltage, :is_battery, :is_bag, 
                                  :is_cordless, :is_blades, :is_bits, :price, :active)
    end 
end
