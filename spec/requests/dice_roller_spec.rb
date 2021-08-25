require 'rails_helper'

RSpec.describe "DiceController", type: :request do
    describe "testing concern" do
      it 'returns a successful response' do
        get "/roll", params: { no_of_dice: 5, dice_sides: "4,5,5,6,6"}
        result = JSON.parse(response.body).with_indifferent_access
        # since we have only 3 different dice we should have ony 3 display texts
        expect(result[:dice_results_array].pluck(:display_text).size).to eq 3
        expect(result[:dice_results_array].pluck(:display_text).include?('Rolling two 5-sided dice.')).to eq true
        expect(result[:dice_results_array].pluck(:display_text).include?('Rolling two 6-sided dice.')).to eq true
        expect(result[:dice_results_array].pluck(:display_text).include?('Rolling a single 4-sided die.')).to eq true

        # rolls should give random result
        get "/roll", params: { no_of_dice: 5, dice_sides: "4,5,5,6,6"}
        result2 = JSON.parse(response.body).with_indifferent_access
        expect(result['total_sum'] == result2['total_sum']).to eq false
        expect(result.keys.include?('total_sum')).to eq true
        expect(result.keys.include?('dice_results_array')).to eq true

      end
    end
end