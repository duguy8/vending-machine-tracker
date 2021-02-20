require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks) }
  end

  describe 'instance methods' do
    it "can find average price for all its snacks" do
      sam = Owner.create(name: "Sam's Snacks")
      dons = sam.machines.create(location: "Don's Mixed Drinks")
      fritos = dons.snacks.create(name: "Fritos", price: "1.25")
      danish = dons.snacks.create(name: "Cheese Danish", price: "2.50")
      reeses = dons.snacks.create(name: "Reeses", price: "1.75")

      expect(dons.average_snack_price.round(2)).to eq(1.83)
    end
  end
end
