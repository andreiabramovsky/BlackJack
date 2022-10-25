# class Player

# имеет имя, банк денег, руку с картами, количество очков в выданных картах
# name, bank, hand, points

# может делать ставку, брать карты на руку, считать количество очков, пропускать ход, показывать количество очков, показывать карты на руке

class Player
  attr_reader :points, :hand, :name
  attr_accessor :bank

  def initialize(name, bank)
    @name = name
    @bank = bank
    @hand = []
    @points = []
  end

  def make_bet(bet)
    @bank -= bet
    puts "Ваша ставка $#{bet}. Осталось $#{bank}"
  end

  def take_card(random_card)
    @hand << random_card
    @points << @hand.last[:score]
  end

  def count_points
    count = []
    points.each do |point|
      # условие второго туза
      if point == 11 && count.include?(point)
        count << 1
      else count << point
      end
    end
    count.sum
  end

  def show_points
    puts "#{name}, Ваши очки - #{count_points}"
  end

  def show_cards
    @hand.each do |card|
      puts "#{card[:suit]}#{card[:denomination]}"
    end
  end

end
