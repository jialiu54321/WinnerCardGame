//
//  Util.swift
//  Winner(Card Game)
//
//  Created by Jia Liu on 12/2/15.
//  Copyright © 2016 Jia Liu. All rights reserved.
//

import Foundation


func geneteCarSetFromCards(cards: [Card]) -> CardSet{
    
    var newCardSetType: carSetType
    switch cards.count {
    case 0: newCardSetType = carSetType.empty
    case 1: newCardSetType = carSetType.single
    case 2: newCardSetType = carSetType.double
    case 3: newCardSetType = carSetType.triple
    case 4: newCardSetType = carSetType.bomb
    default: newCardSetType = carSetType.single
    }
    
    return CardSet(type: newCardSetType, cards: cards)
}
