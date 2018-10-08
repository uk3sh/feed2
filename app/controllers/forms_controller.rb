class FormsController < ApplicationController

  require 'net/http'
  require 'net/https'
  require 'rqrcode'

  skip_after_action :verify_policy_scoped, only: [:new, :create, :sms, :import, :generate_qr, :email, :bulk_email]
  before_action :authenticate_user!
  before_action :set_form, only: [:show, :edit, :update, :destroy]

  # GET /forms
  # GET /forms.json
  def index
    @forms = policy_scope(Form).paginate(:page => params[:page], :per_page => 5)
    
    @recent = Submission.most_recent(5)
    @today = Submission.today
    
  end

  # GET /forms/1
  # GET /forms/1.json
  def show
  end

  # GET /forms/new
  def new
    @form = Form.new   
    authorize @form
  end

  # GET /forms/1/edit
  def edit
    authorize @form
  end

  # POST /forms
  # POST /forms.json
  def create
    @form = policy_scope(Form).new(form_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to @form, notice: 'Form was successfully created.' }
        format.json { render :show, status: :created, location: @form }
      else        
        format.html { render :new }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
    
    @form.generate_url
    @form.save
    
  end

  # PATCH/PUT /forms/1
  # PATCH/PUT /forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to @form, notice: 'Form was successfully updated.' }
        format.json { render :show, status: :ok, location: @form }
      else
        format.html { render :edit }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms/1
  # DELETE /forms/1.json
  def destroy
    @form.destroy
    respond_to do |format|
      format.html { redirect_to forms_url, notice: 'Form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sms
    ph = params[:anything][:number]
    qwerty = params[:anything][:url]    
    sender_id = Account.find_by(id: current_user.account_id).sender_id    
    message = params[:anything][:message]
    puts ph
    puts qwerty
    puts sender_id
    puts message
    Net::HTTP.get(URI.parse("https://control.msg91.com/api/sendhttp.php?authkey=153352AdRjnfzD8x4N5922d370&mobiles=91#{ph}&message=#{message} #{qwerty}?contact=#{ph}&sender=#{sender_id}&route=4&country=91"))
    redirect_back(fallback_location: forms_path, notice: "SMS sent successfully!")
  end

  def import
    params[:file]
    # logger.debug  { params[:file].inspect }
    CSV.foreach(params[:file].path) do |row|
      ph = row[0]
      qwerty = params[:url]
      sender_id = Account.find_by(id: current_user.account_id).sender_id
      message = params[:message]
      puts ph
      puts qwerty
      Net::HTTP.get(URI.parse("https://control.msg91.com/api/sendhttp.php?authkey=153352AdRjnfzD8x4N5922d370&mobiles=91#{ph}&message=#{message} #{qwerty}?contact=#{ph}&sender=#{sender_id}&route=4&country=91"))      
    end
    redirect_back(fallback_location: forms_path, notice: "SMS sent successfully!")
  end

  def generate_qr
    qr_url = params[:url]    
    qr = RQRCode::QRCode.new(qr_url)
    image = qr.as_png(size: 750)
    send_data image, filename: "feedback.png", type: "image/png"
  end

  def redir    
    @zxcv = Form.where(short_url: params[:short_url]).first
    redirect_to @zxcv.url
  end

  def email
    @email = params[:single_email][:email]
    @body = params[:single_email][:message]
    @form_url = params[:single_email][:url]
     
    @from_email = Account.find_by(id: current_user.account_id).sender_email
    FormMailer.send_form_email(@email, @body, @form_url, @from_email).deliver
    redirect_back(fallback_location: forms_path, notice: "Email sent successfully!")
  end

  def bulk_email
    params[:file]
    CSV.foreach(params[:file].path) do |row|      
      @email = row[0]
      @body = params[:message]
      @form_url = params[:url]      
      @from_email = Account.find_by(id: current_user.account_id).sender_email
      FormMailer.send_form_email(@email, @body, @form_url, @from_email).deliver
    end
    redirect_back(fallback_location: forms_path, notice: "Emails sent successfully!")
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = policy_scope(Form).find_by(id: params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_params
      params.require(:form).permit(:name, :sender_ID, :message, :url)
    end
end
