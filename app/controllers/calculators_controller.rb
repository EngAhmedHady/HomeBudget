class CalculatorsController < ApplicationController
  before_action :set_calculator, only: [:show, :edit, :update, :destroy]

  # GET /calculators
  # GET /calculators.json
  def index
    @calculators = Calculator.where(user_id: current_user).order("created_at DESC")
  end

  # GET /calculators/1
  # GET /calculators/1.json
  def show
  end

  # GET /calculators/new
  def new
    @calculator = current_user.calculators.build
  end

  # GET /calculators/1/edit
  def edit
  end

  # POST /calculators
  # POST /calculators.json
  def create
    @calculator = current_user.calculators.build(calculator_params)

    respond_to do |format|
      if @calculator.save
        format.html { redirect_to new_calculator_url , notice: 'Memory was successfully created.' }
        format.json { render :show, status: :created, location: @calculator }
      else
        format.html { render :new }
        format.json { render json: @calculator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calculators/1
  # PATCH/PUT /calculators/1.json
  def update
    respond_to do |format|
      if @calculator.update(calculator_params)
        format.html { redirect_to @calculator, notice: 'Calculator was successfully updated.' }
        format.json { render :show, status: :ok, location: @calculator }
      else
        format.html { render :edit }
        format.json { render json: @calculator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calculators/1
  # DELETE /calculators/1.json
  def destroy
    @calculator.destroy
    respond_to do |format|
      format.html { redirect_to calculators_url, notice: 'Memory was deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calculator
      @calculator = Calculator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calculator_params
      params.require(:calculator).permit(:title, :formula)
    end
end
