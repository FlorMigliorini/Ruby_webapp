class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in 
  before_action :set_review, only: [:show, :edit, :update]
  before_action :redirect_if_not_authorized, only: [:edit, :update, :destroy]

  def index
    # For URL like /courses/1/reviews
    # Get the course with id=1
    @course = Course.find(params[:course_id])
    # Access all reviews for that course
    @reviews = @course.reviews
  end

  def show
    @course = Course.find(params[:course_id])
    # For URL like /courses/1/reviews/2
    # Find an review in courses 1 that has id=2
    @review = @course.reviews.find(params[:id])
  end

  def new
    @course = Course.find(params[:course_id])
    # Associate an review object with course 1
    @review = @course.reviews.build
  end

 # POST /courses/1/reviews
  def create
    @course = Course.find(params[:course_id])
    # For URL like /courses/1/reviews
    # Populate an review associate with course 1 with form data
    # course will be associated with the review
    # @review = @course.reviews.build(params.require(:review).permit!)
    @review = @course.reviews.build(params.require(:review).permit(:details))
    if @review.save
    # Save the review successfully
    redirect_to course_review_url(@course, @review)
    else
    render :action => "new"
    end
  end

  # GET /courses/1/reviews/2/edit
  def edit
    @course = Course.find(params[:course_id])
    # For URL like /courses/1/reviews/2/edit
    # Get review id=2 for course 1
    @review = @course.reviews.find(params[:id])
  end
  # PUT /courses/1/reviews/2
  def update
    @course = Course.find(params[:course_id])
    @review = Review.find(params[:id])
    if @review.update_attributes(params.require(:review).permit(:details))
    # Save the review successfully
    redirect_to course_review_url(@course, @review)
    else
    render :action => "edit"
    end
  end
  # DELETE /courses/1/reviews/2
  def destroy
    @course = Course.find(params[:course_id])
    @review = Review.find(params[:id])
    @review.destroy
    respond_to do |format|
    format.html { redirect_to course_reviews_path(@course) }
    format.xml { head :ok }
  end

  private 

    def review_params
        params.require(:review).permit(:content, :rating, :course_id)
    end

    def set_review
        @review = Review.find_by(id: params[:id])
        if !@review
            flash[:message] = "Review was not found"
            redirect_to reviews_path 
        end
    end

    def redirect_if_not_authorized
        redirect_to reviews_path if @review.user != current_user
    end

end
