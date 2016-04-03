//
//  AIPlayer.swift
//  Winner(Card Game)
//
//  Created by Jia Liu on 4/2/16.
//  Copyright © 2016 Jia Liu. All rights reserved.
//

import Foundation

class AIPlayer: People {
    
    init(cards: [Card], numberOfCards: Int) {
        super.init(playerType: peopleType.AI, cards: cards, numberOfCards: numberOfCards)
    }
   
}