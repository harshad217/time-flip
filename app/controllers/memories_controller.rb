class MemoriesController < ApplicationController
  before_action :set_memory, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @memories = Memory.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @memory = Memory.new
  end
  
  def edit
  end
  
  def create
    @memory = Memory.new(memory_params)
    @memory.user = current_user
    if @memory.save
      flash[:success] = "Memory was successfully created"
      redirect_to memory_path(@memory)
    else
      render 'new'
    end
  end
  
  def update
    if @memory.update(memory_params)
      flash[:success] = "Memory was successfully updated"
      redirect_to memory_path(@memory)
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @memory.destroy
    flash[:danger] = "Memory was successfully deleted"
    redirect_to memories_path
  end
  
  private
  def set_memory
    @memory = Memory.find(params[:id])
  end
  
  def memory_params
    params.require(:memory).permit(:title, :description, :image)
  end
  
  def require_same_user
    if current_user != @memory.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own memories"
      redirect_to root_path
    end
  end
  
  
end