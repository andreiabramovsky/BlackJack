# class Player

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
    puts "#{name}, Ваша ставка $#{bet}. Осталось $#{bank}"
    sleep(2)
  end

  def take_card(random_card)
    @hand << random_card
    @points << @hand.last[:score]
    sleep(1)
  end

  def count_points
    count = []
    points.each do |point|
      if count.sum + point > 21 && ( count.include?(11) || point == 11 )
        count << point - 10
      else 
        count << point
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
