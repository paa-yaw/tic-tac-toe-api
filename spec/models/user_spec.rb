require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'tests validations and associations' do
    # validations
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_presence_of(:username) }
    it { expect(user).to validate_presence_of(:password_digest) }
    it { expect(user).to validate_uniqueness_of(:email) }

    # associations
    it { expect(user).to have_and_belong_to_many(:games) }
    it { expect(user).to have_many(:squares) }
  end
end
