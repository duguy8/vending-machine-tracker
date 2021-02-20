require 'rails_helper'

RSpec.describe "When a visitor visits a vending machine show page", type: :feature do
  scenario "See all snacks associated with their price" do
    sam = Owner.create(name: "Sam's Snacks")
    dons = sam.machines.create(location: "Don's Mixed Drinks")
    fritos = dons.snacks.create(name: "Fritos", price: "1.25")
    danish = dons.snacks.create(name: "Cheese Danish", price: "2.50")
    reeses = dons.snacks.create(name: "Reeses", price: "1.75")

    visit machine_path(dons)

    expect(page).to have_content(fritos.name)
    expect(page).to have_content(fritos.price)
    expect(page).to have_content(danish.name)
    expect(page).to have_content(danish.price)
    expect(page).to have_content(reeses.name)
    expect(page).to have_content(reeses.price)
  end

  scenario "I also see the average price for all snacks in the machine" do
    sam = Owner.create(name: "Sam's Snacks")
    dons = sam.machines.create(location: "Don's Mixed Drinks")
    fritos = dons.snacks.create(name: "Fritos", price: "1.25")
    danish = dons.snacks.create(name: "Cheese Danish", price: "2.50")
    reeses = dons.snacks.create(name: "Reeses", price: "1.75")

    visit machine_path(dons)

    expect(page).to have_content("Average price: 1.83")
  end
end
