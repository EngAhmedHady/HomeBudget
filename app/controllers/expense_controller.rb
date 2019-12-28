class ExpenseController < ApplicationController
	require 'date'

	def index
		@Date = Date.today.day.to_s + " "+Date::MONTHNAMES[Date.today.month].to_s+", "+Date.today.year.to_s

	end

	def new
		@object = Expense.create(user_id: => current_user)
		@NewExp = Expense.where(user_id: current_user).order("created_at DESC")
	end

	def create
		@NewExp = current_user.expenses.build(Exp_params)
		if @NewExp.save
			@Confirmation = "New Expenses Saved 👌"
			render index 
		else
			render new
		end
	end

	private
	def Exp_params
		Params.require(:expense).permit(:date, :paid, :type, :details)
	end
end
