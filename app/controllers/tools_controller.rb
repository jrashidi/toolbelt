class ToolsController < ApplicationController
  before_action :set_tool, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @tools = current_user.tools
  end

  def show
  end

  def new
    @tool = current_user.tools.build 
  end

  def create
    @tool = current_user.tools.build(tool_params)

    if @tool.save 
      redirect_to @tool, notice: "Saved Successfully"
    else 
      render :new 
    end 
  end 

  def edit
  end

  def update
    if @room.update(tool_params)
      redirect_to @tool, notice: "Updated Successfully"
    end 
  end

  private 
    def set_tool
      @tool = Tool.find(param[:id])
    end

    def room_params
      params.require(:tool).permit(:type, :model_type, :listing_name, :summary, :address, :extra_tools, :dimensions, :voltage, :is_battery, :is_bag, :is_cordless, :is_blades, :is_bits, :price, :active)
    end 
end
