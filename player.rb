# class Player

# имеет имя, банк денег, руку с картами, количество очков в выданных картах
# name, bank, hand, points

# может делать ставку, брать карты на руку, считать количество очков, пропускать ход, показывать количество очков, показывать карты на руке

class Player

  def initialize(name)
    @name = name
    @bank = bank
    @hand = []
    @points = []
  end

  def make_bet
  end

  def take_card
  end

  def count_points
  end

  def skip
  end

  def show_points
  end

  def show_cards
  end
  
end
