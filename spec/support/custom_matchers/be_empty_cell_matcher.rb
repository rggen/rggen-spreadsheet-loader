RSpec::Matchers.define(:be_empty_cell) do |position = nil|
  match do |actual|
    return false unless actual.empty_cell?
    return false if position && (actual.position != position)
    true
  end

  failure_message do
    if actual.empty_cell? && position
      "cell is empty but position is not matched\n" \
      "expected: #{position}\n" \
      "  actual: #{actual.position}\n\n"
    else
      'expected cell to be empty but not'
    end
  end
end
