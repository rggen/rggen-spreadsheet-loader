# frozen_string_literal: true

RSpec::Matchers.define(:be_empty_cell) do |position = nil|
  match do |actual|
    return false unless actual.empty_cell?
    return false unless match_position?(position, actual.position)
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

  private

  def match_position?(expected_position, actual_position)
    return true unless expected_position

    values_match?(expected_position, actual_position)
  end
end
