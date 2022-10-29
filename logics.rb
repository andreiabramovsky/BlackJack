# class Logics

require_relative 'cards'
require_relative 'player'
require_relative 'dealer'
require_relative 'gambler'

class Logics
  BANK = 100
  BET = 10
  ACTIONS = [
    {id: 0, title: "Пропустить ход", action: :skip},
    {id: 1, title: "Взять карту", action: :add_card},
    {id: 2, title: "Показать карты", action: :show_cards},
  ].freeze

  attr_reader :gambler, :dealer, :cards_deck

  def initialize
    puts "Игра Black Jack"
    sleep(1)
    puts "Введите Ваше имя"
    gambler_name = gets.chomp.capitalize
    puts "Здравствуйте, #{gambler_name}. Мы начинаем игру."
    sleep(1)
    puts "=============================================="
    puts "У вас в банке $#{BANK}. Ставка равна $#{BET}"
    sleep(2)
    @gambler = Gambler.new(gambler_name, BANK)
    @dealer = Dealer.new("Дилер", BANK)
    @cards_deck = Cards.new
  end

  def take_card(who, amount_of_cards = 1)
    amount_of_cards.times { who.take_card(cards_deck.random_card) }
  end

  def action
    ACTIONS.each { |item| puts "#{item[:id]} - #{item[:title]}" }
    puts 'Вашe действие: '
    choice = gets.chomp
    raise RuntimeError, "Введите или 0, или 1, или 2." unless %w[0 1 2].include?(choice)
    puts
    send(ACTIONS[choice.to_i][:action])
    rescue RuntimeError => e
      puts e.message
    retry
  end

  def add_card
    take_card(gambler)
    gambler.show_points
    if gambler.count_points > 21
      puts "Перебор. Вы проиграли"
      take_bank(dealer)
      continue?
    else
      dealer_turn
    end
  end

  def skip
    dealer_turn_second
  end

  def show_cards
    who_win
  end

  def continue?
    puts "Сыграем еще раз?"
    puts "1 - да, 0 - нет"
    choice = gets.chomp
    if choice == "1"
      reset
      start
    else choice == "0"
      exit
    end
    raise 'Введите 1, если желаете продолжить игру, 0 - выйти из игры.' unless %w[0 1].include?(choice)
    rescue RuntimeError => e
    puts e.message
    retry
  end

  def dealer_turn
    if dealer.count_points >= 17
      puts 'Дилер пропускает ход'
      who_win
    else
      take_card(dealer)
      puts 'Дилер взял одну карту.'
      who_win
    end
  end

  def dealer_turn_second
    if dealer.count_points >= 17
      puts 'Дилер пропускает ход'
      sleep(1)
      puts
      return_to_player_turn
    else
      take_card(dealer)
      puts 'Дилер взял одну карту.'
      puts
      sleep(1)
      return_to_player_turn
    end
  end

  def return_to_player_turn
    arr = ACTIONS.drop(1)
    arr.each { |item| puts "#{item[:id]} - #{item[:title]}" }
    puts "Ваше действие: "
    choice = gets.chomp
    raise "Введите 1 или 2" unless %w[1 2].include?(choice)
    send(arr[choice.to_i - 1][:action])
    rescue RuntimeError => e
      puts e.message
      retry
  end  

  def who_win
    puts "Вскрытие карт"
    if gambler.count_points > dealer.count_points || dealer.count_points > 21
      take_bank(gambler)
      dealer_cards_and_points
      puts "Поздравляем! Вы победили."
      puts "Ваш банк: $#{gambler.bank}"
    elsif gambler.count_points < dealer.count_points
      take_bank(dealer)
      dealer_cards_and_points
      puts "Вы проиграли."
      puts "Ваш банк: $#{gambler.bank}"
    else
      return_bet(dealer)
      return_bet(gambler)
      dealer_cards_and_points
      puts "Ничья."
      puts "Ваш банк: $#{gambler.bank}"
    end
  end

  def take_bank(who)
    who.bank += 2 * BET
  end

  def return_bet(who)
    who.bank += BET
  end


  def dealer_cards_and_points
    puts "Карты дилера:"
    dealer.show_cards
    dealer.show_points
  end

  def reset
    gambler.hand.clear
    gambler.points.clear
    dealer.hand.clear
    dealer.points.clear    
  end

  def start
    loop do
      gambler.make_bet(BET)
      dealer.make_bet(BET)
      puts
      puts "Раздача карт"
      puts
      sleep(1)
      puts "Ваши карты:"
      take_card(gambler, 2)
      gambler.show_points
      sleep(1)
      puts
      puts "Карты дилера"
      take_card(dealer, 2)
      puts
      sleep(2)
      action
      continue?
  end

end
end
