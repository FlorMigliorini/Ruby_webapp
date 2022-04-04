class CoursesController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :set_course, only: [:show, :edit, :update, :destroy ]
  before_action :authenticate_user!
  #before_action :redirect_if_not_author_or_admin, only: [:edit, :update]

  # GET /courses or /courses.json
  def index
    @courses = Course.all.includes(:user).decorate

    #@course = Course.all.paginate(page: params[:page])

     #adding code for the search
    if params[:title]
      @courses = Course.where('title LIKE ?', "%#{params[:title]}%")
    else
      @courses = Course.all
    end  
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :rating, :description, :image)
    end

    def redirect_if_not_author_or_admin
    redirect_to courses_path if !@course || @course.user != current_user && !current_user.admin?
  end
end
