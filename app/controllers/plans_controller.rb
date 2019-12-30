class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.where(user: current_user).last
    if @plans == nil
      redirect_to new_plan_url
    else
      @expenses = Expense.where(user_id: current_user)
      @TotalFixEx = @expenses.where(kind: 0).where("cast(strftime('%m', date) as int) = ?",Date.today.month).sum(:paid)

      @TotalEx = @expenses.where('date >= ?', @plans.start_date).where('date <= ?', Date.today).sum(:paid)
      @NumOfMon = (Date.today.year * 12 + Date.today.month) - (@plans.start_date.year * 12 + @plans.start_date.month)

      @Rloans = @plans.loans.to_f - @expenses.where(kind: 2).sum(:paid)
      @situation = (@plans.income * @NumOfMon) - @TotalEx + @plans.old_savings
    end
    
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = current_user.plans.build
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = current_user.plans.build(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to plans_url, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to plans_url, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:start_date, :end_date, :income, :fixed_ex, :loans, :target_sa, :old_savings)
    end
end
