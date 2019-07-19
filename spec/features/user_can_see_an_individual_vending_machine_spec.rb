require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create!(name: "Sam's Snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")
    wcb = dons.snacks.create!(name: 'White Castle Burger', price: 3.50)
    rocks = dons.snacks.create!(name: 'Pop Rocks', price: 1.50)
    cheetos = dons.snacks.create!(name: 'Flamin Cheetos', price: 2.50)

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
    expect(page).to have_content("White Castle Burger")
    expect(page).to have_content("Price: $3.50")
    expect(page).to have_content("Price: $1.50")
    expect(page).to have_content("Price: $2.50")
    expect(page).to have_content("Average Price: $2.50")
  end
end
