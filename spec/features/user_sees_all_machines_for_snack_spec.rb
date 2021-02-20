require 'rails_helper'

RSpec.describe "When a visitor visits a snack show page", type: :feature do
  scenario "See the name, price, list of locations, average price for each location, count of snacks" do
    sam = Owner.create(name: "Sam's Snacks")
    dons = sam.machines.create(location: "Don's Mixed Drinks")
    basement = sam.machines.create(location: "Turing Basement")
    fritos = dons.snacks.create(name: "Fritos", price: "1.25")
    danish = dons.snacks.create(name: "Cheese Danish", price: "2.50")
    reeses = dons.snacks.create(name: "Reeses", price: "1.75")
    lays = basement.snacks.create(name: "Jalapeno Chips", price: "1.99")
    basement.snacks << [reeses]

    visit snack_path(reeses)

    expect(page).to have_content(reeses.name)
    expect(page).to have_content(reeses.price)

    within("#location-#{dons.id}") do
      expect(page).to have_content(dons.location)
      expect(page).to have_content("3 kinds of snacks")
      expect(page).to have_content("Average price of $1.83")
    end

    within("#location-#{basement.id}") do
      expect(page).to have_content(basement.location)
      expect(page).to have_content("2 kinds of snacks")
    end
  end
end
