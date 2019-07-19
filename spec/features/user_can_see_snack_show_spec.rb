require 'rails_helper'

RSpec.describe 'When a user visits a snack show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create!(name: "Sam's Snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")
    rons  = owner.machines.create!(location: "Ron's Mixed Drinks")
    jons  = owner.machines.create!(location: "Jon's Mixed Drinks")
    wcb = dons.snacks.create!(name: 'White Castle Burger', price: 3.50)
    rocks = dons.snacks.create!(name: 'Pop Rocks', price: 1.50)
    cheetos = dons.snacks.create!(name: 'Flamin Cheetos', price: 2.50)
    rons.snacks << wcb
    doritos = rons.snacks.create!(name: 'Flamin Doritos', price: 2.45)
    jerky = rons.snacks.create!(name: 'Flamin Jerky', price: 2.85)
    jerky = jons.snacks.create!(name: 'Regular Jerky', price: 1.03)

    visit snack_path(wcb)

    expect(page).to have_content("White Castle Burger")
    expect(page).to have_content("Price: $3.50")

    within("#machine-#{dons.id}") do
      expect(page).to have_content("Location: Don's Mixed Drinks")
      expect(page).to have_content("Average Price: $2.50")
      expect(page).to have_content("Item Count: 3")
    end

    within("#machine-#{rons.id}") do
      expect(page).to have_content("Location: Ron's Mixed Drinks")
      expect(page).to have_content("Average Price: $2.93")
      expect(page).to have_content("Item Count: 3")
    end
  end
end
