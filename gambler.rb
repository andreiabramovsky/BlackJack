# class Gambler

class Gambler < Player
  def take_card(random_card)
    super(random_card)
    puts "#{@hand.last[:suit]}#{@hand.last[:denomination]}"
  end
end
