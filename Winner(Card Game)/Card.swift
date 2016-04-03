//
//  Card.swift
//  Winner(Card Game)
//
//  Created by Jia Liu on 11/12/15.
//  Copyright © 2016 Jia Liu. All rights reserved.
//

import Foundation

enum cardType: String {
    case heart
    case spade
    case club
    case diamond
    case jocker
}

class Card: Comparable {
    var number: Int
    var type: cardType
    var image: String

    
    init(number: Int, type: cardType, image: String){
        self.number = number
        self.type = type
        self.image = image
    }
    
    func getNumber() -> Int {
        return number
    }
    
    func getType() -> cardType {
        return type
    }
    
    func toString() -> String{
        return type.rawValue + "\(number)"
    }
    
    func isEqualTo (that: Card) -> Bool {//ignoring the type
        return self.getNumber() == that.getNumber()
    }
    
}

func == (this: Card, that: Card) -> Bool {
    return this.getNumber() == that.getNumber() && this.getType() == that.getType();
}


//in this game, 3<4<5......<J<Q<K<A(1)<2<SmallJocker(14)<Jocker(15)
func < (this: Card, that: Card) -> Bool {
    var x = this.getNumber()
    var y = that.getNumber()
    
    if ( (x > 2 && x < 14 && y > 2 && y < 14) || ( (x <= 2 || x >= 14) && (y <= 2 || y >= 14) ) ){
        return x < y;
    } else if (x <= 2 || x >= 14) {
        return false
    } else {
        return true
    }
    
}