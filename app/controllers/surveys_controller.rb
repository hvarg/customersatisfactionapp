class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  def index
    @surveys = Survey.all
  end
  
  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    if params[:very_bad] != nil
        @survey = Survey.new(score: 2)
    elsif params[:bad] != nil
        @survey = Survey.new(score: 4)
    elsif params[:neutral] != nil
        @survey = Survey.new(score: 6)
    elsif params[:good] != nil
        @survey = Survey.new(score: 8)
    elsif params[:very_good] != nil
        @survey = Survey.new(score: 10)
    end
    # @survey.attention_desk_id = 1
    respond_to do |format|
      if @survey.save
        format.html { redirect_to edit_survey_path(@survey) }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    pais = ""
    mensaje = "¡Gracias! "
    if params[:venezuela] != nil
      pais = "venezuela"
    elsif params[:haiti] != nil
      pais = "haiti"
      mensaje = "¡di ou mèsi!"
    elsif params[:peru] != nil
      pais = "peru"
    elsif params[:colombia] != nil
      pais = "colombia"
    elsif params[:bolivia] != nil
      pais = "bolivia"
    elsif params[:argentina] != nil
      pais = "argentina"
    elsif params[:ecuador] != nil
      pais = "ecuador"
    elsif params[:espana] != nil
      pais = "espana"
    elsif params[:brazil] != nil
      pais = "brazil"
    end
    @survey.country = pais
    respond_to do |format|
      if @survey.save
        format.html { redirect_to new_survey_path, notice: mensaje }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end
  #
  # # DELETE /surveys/1
  # # DELETE /surveys/1.json
  # def destroy
  #   @survey.destroy
  #   respond_to do |format|
  #     format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  # 
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_survey
       @survey = Survey.find(params[:id])
  end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   # def survey_params
  #   #   params.require(:survey).permit()
  #   # end
end
