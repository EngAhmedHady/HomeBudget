class ExpenseController < ApplicationController
	

	def index

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
