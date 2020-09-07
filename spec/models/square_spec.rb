require 'rails_helper'

RSpec.describe Square, type: :model do
  let!(:square) { build(:square) }

  describe 'test validations and associations' do
    # validations
    it { expect(square).to validate_presence_of(:position) }

    # associations
    it { expect(square).to belong_to(:user) }
  end
end
