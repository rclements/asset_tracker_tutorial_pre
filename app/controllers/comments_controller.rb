class CommentsController < ApplicationController
  before_filter :load_comment, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_comment, :only => [:new, :create] 

  protected
  def load_new_comment
    @comment = Comment.new(params[:comment])
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end
  
  public
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      @comment.update_attributes(params[:comment])
      flash[:notice] = "Comment created successfully."
      redirect_to_ref_url
    else
      flash.now[:error] = "There was a problem creating the comment."
      render :action => :new
    end
  end

  def show
  end

  def new
  end

  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end
end
