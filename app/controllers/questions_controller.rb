class QuestionsController < ApplicationController

  skip_after_action :verify_policy_scoped, only: [:new, :create]
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_form, only: [:create, :index, :new, :edit]

  # GET /questions
  # GET /questions.json
  def index  
    @questions = policy_scope(@form.questions).paginate(:page => params[:page], :per_page => 5)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = policy_scope(@form.questions).build
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create    
    @question = policy_scope(@form.questions).build(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to form_questions_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to form_questions_path, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to form_questions_path, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = policy_scope(Question).find_by(id: params[:id])
    end

    def set_form      
      @form = policy_scope(Form).find_by(id: params[:form_id])            
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question_text, :question_type, :option => [])
    end
end
