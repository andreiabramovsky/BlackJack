# class Dealer

class Dealer < Player
  def take_card(random_card)
    super(random_card)
    puts "**"
  end
end
