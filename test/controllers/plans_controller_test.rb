require 'test_helper'

class PlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plan = plans(:one)
  end

  test "should get index" do
    get plans_url
    assert_response :success
  end

  test "should get new" do
    get new_plan_url
    assert_response :success
  end

  test "should create plan" do
    assert_difference('Plan.count') do
      post plans_url, params: { plan: { end_date: @plan.end_date, fixed_ex: @plan.fixed_ex, income: @plan.income, old_savings: @plan.old_savings, start_date: @plan.start_date, target_sa: @plan.target_sa, user_id: @plan.user_id } }
    end

    assert_redirected_to plan_url(Plan.last)
  end

  test "should show plan" do
    get plan_url(@plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_plan_url(@plan)
    assert_response :success
  end

  test "should update plan" do
    patch plan_url(@plan), params: { plan: { end_date: @plan.end_date, fixed_ex: @plan.fixed_ex, income: @plan.income, old_savings: @plan.old_savings, start_date: @plan.start_date, target_sa: @plan.target_sa, user_id: @plan.user_id } }
    assert_redirected_to plan_url(@plan)
  end

  test "should destroy plan" do
    assert_difference('Plan.count', -1) do
      delete plan_url(@plan)
    end

    assert_redirected_to plans_url
  end
end
