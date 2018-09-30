class SubmissionsController < ApplicationController

  skip_after_action :verify_policy_scoped, only: [:new, :create, :thanks]
  before_action :authenticate_user!, except: [:new, :create, :thanks]

  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_action :set_form, only: [:show, :index]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = @form.submissions.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @ans = @submission.answers
  end

  # GET /submissions/new
  def new  
    @form = Form.find(params[:form_id])  
    @submission = @form.submissions.new
    @qst = @form.questions.all  
    @submission.answers.build
    render layout: "testlayout"  
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create  
    @form = Form.find(params[:form_id])  
    @submission = @form.submissions.new(submission_params)
    @submission.form_id = params[:form_id]
    @submission.account_id = @form.account_id                   
    @submission.save!
    redirect_to :thanks    
  end

  def thanks
    render layout: "testlayout"
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    def set_form
     @form = policy_scope(Form).find_by(id: params[:form_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:contact, answers_attributes: [:answer_text, :question_id, :account_id])
    end
end
