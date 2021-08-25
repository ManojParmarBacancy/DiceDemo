module DiceRoller
  extend ActiveSupport::Concern

  def roll_the_dice
    sides_frequency_hash = format_the_input
    rolling_results(sides_frequency_hash)
  end

  def rolling_results(sides_frequency_hash)
    result_object = { total_sum: 0, dice_results_array: []}
    sides_frequency_hash.each do |sides, frequency|
        generate_rolls(sides, frequency, result_object)
    end
    result_object
  end

  def generate_rolls(sides, frequency, result_object)
    outcomes = []
    frequency.times do 
       outcomes << rand(sides) + 1
    end
    result_object[:total_sum] += outcomes.sum
    result_object[:dice_results_array] << { outcomes: outcomes, display_text: display_text(frequency, sides) }
  end

  private

  def display_text(frequency, sides)
    if frequency == 1
      "Rolling a single #{sides}-sided die."
    else
      "Rolling #{frequency.humanize} #{sides}-sided dice."
    end
  end

  def format_the_input
    input_array = params[:dice_sides].split(',').map(&:to_i)
    generate_frequencies_hash(input_array)
  end

  def generate_frequencies_hash(input_array)
    frequencies_hash = {}
    input_array.map do |input|
        if frequencies_hash[input]
            frequencies_hash[input] +=1
        else
            frequencies_hash[input] = 1
        end
    end
    frequencies_hash
  end
end