class FormsController < ApplicationController

  require 'net/http'
  require 'net/https'
  require 'rqrcode'

  before_action :authenticate_user!
  before_action :set_form, only: [:show, :edit, :update, :destroy]

  # GET /forms
  # GET /forms.json
  def index
    @forms = Form.all
    @recent = Submission.most_recent(5)
    @today = Submission.today
    @good_counts = Answer.group(:answer_text).count["good"]
    @bad_counts = Answer.group(:answer_text).count["bad"]
  end

  # GET /forms/1
  # GET /forms/1.json
  def show
  end

  # GET /forms/new
  def new
    @form = Form.new    
  end

  # GET /forms/1/edit
  def edit
  end

  # POST /forms
  # POST /forms.json
  def create
    @form = Form.new(form_params)

    respond_to do |format|
      if @form.save
        format.html { redirect_to @form, notice: 'Form was successfully created.' }
        format.json { render :show, status: :created, location: @form }
      else
        format.html { render :new }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
    
    @form.generate_url(request.subdomain, request.domain)
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
    sender_id = params[:anything][:sender_ID]
    message = params[:anything][:message]
    puts ph
    puts qwerty
    puts sender_id
    puts message

    Net::HTTP.get(URI.parse("https://control.msg91.com/api/sendhttp.php?authkey=153352AdRjnfzD8x4N5922d370&mobiles=91#{ph}&message=#{message} #{qwerty}?contact=#{ph}&sender=#{sender_id}&route=4&country=91"))
    redirect_to forms_path
  end

  def import
    params[:file]
    # logger.debug  { params[:file].inspect }
    CSV.foreach(params[:file].path) do |row|
      ph = row[0]
      qwerty = params[:url]
      puts ph
      puts qwerty
      Net::HTTP.get(URI.parse("https://control.msg91.com/api/sendhttp.php?authkey=153352AdRjnfzD8x4N5922d370&mobiles=91#{ph}&message=Hello! Please leave feedback here #{qwerty}?contact=#{ph}&sender=UKESHV&route=4&country=91"))
    end
  end

  def generate_qr
    qr_url = params[:url]    
    qr = RQRCode::QRCode.new(qr_url)
    image = qr.as_png(size: 750)
    send_data image, filename: "feedback.png", type: "image/png"
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params[:id])
    end

    
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_params
      params.require(:form).permit(:name, :sender_ID, :message, :url)
    end
end
