require 'rails_helper'

RSpec.describe Game, type: :model do
  let!(:game) { build(:game) }

  describe 'tests validations and associations' do
    # validations
    it { expect(game).to validate_presence_of(:name) }
    it { expect(game).to validate_presence_of(:status) }
    it { expect(game).to validate_presence_of(:duration) }

    # associations
    it { expect(game).to have_and_belong_to_many(:users) }
  end
end
