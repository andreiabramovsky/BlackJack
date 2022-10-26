# class Cards

# масть, номинал, количество очков
# генерация колоды
# выбор случайной карты

class Cards

SUITS = %w[♥ ♦ ♣ ♠].freeze
DENOMINATION = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze
SCORE = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]

attr_reader :cards_deck

  def initialize
    @cards_deck = []
    generate_deck
  end

  # генерация колоды
  def generate_deck
    SUITS.each do |suit|
      DENOMINATION.each_with_index do |denomination, index|
        @cards_deck << {suit: suit, denomination: denomination, score: SCORE[index]}
      end
    end
    cards_deck.shuffle
  end

  # случайная карта из сгенерированной колоды
  def random_card
    cards_deck.sample
  end
