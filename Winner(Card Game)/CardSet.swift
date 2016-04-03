//
//  CardSet.swift
//  Winner(Card Game)
//
//  Possbile combinations of cards one can play
//
//  Created by Jia Liu on 12/12/15.
//  Copyright © 2016 Jia Liu. All rights reserved.
//

import Foundation

enum carSetType: Int {
    case empty = 0
    case single = 1
    case double = 2
    case triple = 3
    case bomb = 4
}

class CardSet: Comparable  {
    var type: carSetType
    var cards: [Card] //value on the card
    
    init(type: carSetType, cards: [Card]){
        self.type = type
        self.cards = cards
    }
    
    init(cardSet: CardSet){
        self.type = cardSet.type
        var tempCards = [Card]()
        for var a = 0; a < cardSet.cards.count; ++a{
            tempCards.append(cardSet.cards[a])
        }
        self.cards = tempCards
    }
    
    func isEmpty() -> Bool {
        return self.type.rawValue == 0
    }
    
}

func == (this: CardSet, that: CardSet) -> Bool {
    if this.type.rawValue != 4 && that.type.rawValue != 4 && this.type != that.type{
        return true
    }
    return this.type == that.type && this.cards[0] == that.cards[0]
}

func < (this: CardSet, that: CardSet) -> Bool {
    if this.type == that.type {
        return this.cards[0] < that.cards[0]
    } else if (this.type.rawValue != 4 && that.type.rawValue == 4) {
        return true
    } else if (this.type.rawValue == 4 && that.type.rawValue != 4) {
        return false
    }
    return false
}




