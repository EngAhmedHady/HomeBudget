class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @Date = Date.today.day.to_s + " "+Date::MONTHNAMES[Date.today.month].to_s+", "+Date.today.year.to_s
    @currentMonth = Date.today.month 
    @planed = Plan.where(user: current_user).last
    @expenses = Expense.where(user_id: current_user)
    @TotalEx = @expenses.where("cast(strftime('%m', date) as int) = ?",Date.today.month).
                         where("cast(strftime('%Y', date) as int) = ?",Date.today.year)
    @BudStatus = @planed.target_sa - @TotalEx.sum(:paid)
    if Date.today.day != 31 && @BudStatus > 0
      @AvgExp = @BudStatus / (31 - Date.today.day)
    elsif @BudStatus < 0
      @AvgExp = 0  
    else
      @AvgExp = @BudStatus
    end
    # @expenses = Expense.all
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @Date = Date.today
    @expense = current_user.expenses.build
  end

  # GET /expenses/1/edit
  def edit
  end

  def statistics
     @expenses = Expense.where(user_id: current_user)
     @plans = Plan.where(user: current_user).last
     @TotalEx = @expenses.where("cast(strftime('%m', date) as int) = ?",Date.today.month).
                         where("cast(strftime('%Y', date) as int) = ?",Date.today.year)

     @Rem = @plans.income - @TotalEx.sum(:paid)
  end

  def list
     @data = Expense.where(user_id: current_user)
  end


  # POST /expenses
  # POST /expenses.json
  def create
    @expense = current_user.expenses.build(expense_params)

    respond_to do |format|
      if @expense.save
        @Confirmation = "New Expenses Saved 👌"
        
        format.html { redirect_to expenses_url, notice: 'New Expenses Saved 👌' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expenses_url, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:date, :paid, :kind, :details)
    end
end
