//
//  People.swift
//  Winner(Card Game)
//
//  Created by Jia Liu on 12/2/15.
//  Copyright © 2016 Jia Liu. All rights reserved.
//

import Foundation

enum peopleType {
    case human
    case AI
}

class People {
    var playerType: peopleType
    var cards: [Card]
    var numberOfCards: Int
    
    init(playerType: peopleType, cards: [Card], numberOfCards: Int){
        self.playerType = playerType
        self.cards = cards
        self.numberOfCards = numberOfCards
    }
    
    func play () -> Bool{
        return true;
    }
    
    func deal (tableCardSet: CardSet) -> CardSet{
        var a: Int = 0
        while( a < cards.count){
            var tempCarSet = geneteCardSet(a)
            if tableCardSet.isEmpty() {
                deleteCards(tempCarSet)
                return tempCarSet
            } else {
                if tableCardSet < tempCarSet{
                    deleteCards(tempCarSet)
                    return tempCarSet
                }
            }
            a += tempCarSet.cards.count
        }
        return geneteCarSetFromCards([Card]())
    }
    
    func geneteCardSet(index: Int) -> CardSet{
        var cardToSubmit = [Card]()
        for var a = index; a < cards.count; ++a{
            if(cardToSubmit.count == 0){
                cardToSubmit.append(cards[a])
            } else {
                if(cardToSubmit[0].isEqualTo(cards[a])){
                    cardToSubmit.append(cards[a])
                } else {
                    break
                }
            }
        }
        
        return geneteCarSetFromCards(cardToSubmit)
    }
    
    func deleteCards(cardsToSubmit: CardSet){
        for var a = 0; a < cardsToSubmit.cards.count; ++a{
            var index = cards.indexOf(cardsToSubmit.cards[a])
            cards.removeAtIndex(index!)
        }
    }

}


