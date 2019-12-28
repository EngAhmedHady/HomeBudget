json.extract! expense, :id, :user_id, :date, :paid, :type, :details, :created_at, :updated_at
json.url expense_url(expense, format: :json)
