module Blackjack
  def self.parse_card(card)
    case card
    when 'ace'
      11
    when 'two'
      2
    when 'three'
      3
    when 'four'
      4
    when 'five'
      5
    when 'six'
      6
    when 'seven'
      7
    when 'eight'
      8
    when 'nine'
      9
    when 'ten'
      10
    when 'jack'
      10
    when 'queen'
      10
    when 'king'
      10
    else
      0
    end
  end

  def self.card_range(card1, card2)
    case parse_card(card1).to_i + parse_card(card2).to_i
    when 4..11
      'low'
    when 12..16
      'mid'
    when 17..20
      'high'
    when 21
      'blackjack'
    end
  end

  def self.first_turn(card1, card2, dealer_card)
    total_score = parse_card(card1) + parse_card(card2)

    if total_score == 21 && dealer_card != 'ace' && dealer_card != 'ten' && !face_card?(dealer_card)
      "W"
    elsif (total_score == 21 && (dealer_card == 'ace' || dealer_card == 'ten' || face_card?(dealer_card))) || (card_range(card1, card2) == 'high' || (card_range(card1, card2) == 'mid' && parse_card(dealer_card) < 7))
      "S"
    elsif (card_range(card1, card2) == 'mid' && parse_card(dealer_card) >= 7) || (total_score < 17)
      "H"
    elsif card1 == 'ace' || card2 == 'ace'
      "P"
    end
  end

  def self.face_card?(card)
    ['jack', 'queen', 'king'].include?(card)
  end
end
