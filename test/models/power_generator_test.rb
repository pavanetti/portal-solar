require 'test_helper'

class PowerGeneratorTest < ActiveSupport::TestCase
  test "should search by term in description or name" do
    term = 'YC600i'
    found = PowerGenerator.by_term term
    assert(found.all? do |pg|
        pg.name.include?(term) || pg.description.include?(term)
    end)
  end
end
