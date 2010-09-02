Then /^I should see the following work_units:$/ do |expected_work_units_table|
  expected_work_units_table.diff!(tableish('table tr', 'td,th'))
end
