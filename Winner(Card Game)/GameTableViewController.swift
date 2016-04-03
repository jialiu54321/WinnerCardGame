//
//  GameTableViewController.swift
//  Winner(Card Game)
//
//  Created by Jia Liu on 11/12/15.
//  Copyright © 2016 Jia Liu. All rights reserved.
//

import UIKit


//function to shuffle cards
extension Array {
    func shuffled() -> [Element] {
        if count < 2 { return self }
        var list = self
        for i in 0..<(list.count - 1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            var tempL = list[i]
            list[i] = list[j]
            list[j] = tempL
        }
        return list
    }
}

var cardButtons = [UIButton]()
var currentHumanPlayerCardSet = CardSet(type: carSetType.empty, cards: [Card]())
var cardSetToSubmit = [Card]()
var currentTableCardSet = CardSet(type: carSetType.empty, cards: [Card]())
var players = [People]()
var tableCardSetViews = [UIImageView]()
var rightToLead: Int = 0 //index of the player who has the right to lead
var passCount: Int = 0 //count how many player choose to pass during a round of game
var numberOfPlayer = 2;
var cardPool = [Card]()

let submitButton = UIButton(type: UIButtonType.System)
let passButton = UIButton(type: UIButtonType.System)
let startButton = UIButton(type: UIButtonType.System)

var alertController = UIAlertController(title: "Game Over", message: "", preferredStyle: .Alert)

let screenSize: CGRect = UIScreen.mainScreen().bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let cardImageWidth = screenWidth/27
let cardImageHeight = cardImageWidth * 1.5
let cardImageTop = screenHeight - cardImageHeight

class GameTableViewController: UIViewController {
    //Force landscape mode in this view
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    @IBOutlet weak var backButtom: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named:"Background")!)
        //let backgroundImageView = UIImageView(image: UIImage(named: "LandscopeBackGround"))
        //backgroundImageView.frame = view.frame
        //backgroundImageView.contentMode = .ScaleAspectFill
        //view.addSubview(backgroundImageView)
        //view.sendSubviewToBack(backgroundImageView)
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "LandscopeBackGround")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
        
        //Force landscape mode in this view
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.LandscapeLeft.rawValue, forKey: "orientation")
        
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        
        
        
        submitButton.setBackgroundImage(UIImage(named: "SubmitBtn"), forState: UIControlState.Normal)
        submitButton.frame = CGRectMake(screenWidth - 70, cardImageTop - 70, 50, 50)
        submitButton.backgroundColor = UIColor.clearColor()
        submitButton.addTarget(self, action: "submitButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(submitButton)
        
       
        passButton.setBackgroundImage(UIImage(named: "PassBtn"), forState: UIControlState.Normal)
        passButton.frame = CGRectMake(screenWidth - 140, cardImageTop - 70, 50, 50)
        passButton.backgroundColor = UIColor.clearColor()
        passButton.addTarget(self, action: "passButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(passButton)
        
        tableCardSetViews = generateTableCardSetViews()
        
        startButton.setBackgroundImage(UIImage(named: "NewGameBtn"), forState: UIControlState.Normal)
        startButton.frame = CGRectMake(screenWidth - 210, cardImageTop - 70, 50, 50)
        startButton.backgroundColor = UIColor.clearColor()
        startButton.addTarget(self, action: "gameStart:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startButton)
        
        backButtom.frame = CGRectMake(10, 10, 90, 70)
        backButtom.setBackgroundImage(UIImage(named: "BackBtn"), forState: UIControlState.Normal)
        backButtom.backgroundColor = UIColor.clearColor()
        backButtom.addTarget(self, action: "backToHomeView:", forControlEvents: UIControlEvents.TouchUpInside)
        
        if numberOfPlayer == 2 {
            var opponent1 = UIImageView(frame: CGRectMake(screenWidth/2 - 25, 20, 50, 50))
            opponent1.image = UIImage(named: "Opponent")
            self.view.addSubview(opponent1)
        }
        

    }
    
    override func viewDidAppear(animated: Bool) {
        
        let action = UIAlertAction(title: "Confirm", style: .Default, handler: nil)
        alertController.addAction(action)

    }
    
    
    func newGameStart(){
        
        currentHumanPlayerCardSet = CardSet(type: carSetType.empty, cards: [Card]())
        cardSetToSubmit = [Card]()
        currentTableCardSet = CardSet(type: carSetType.empty, cards: [Card]())
        players = [People]()
        rightToLead = 0 //index of the player who has the right to lead
        passCount = 0 //count how many player choose to pass during a round of game
        cardPool = [Card]()
        
        cardButtons = [UIButton]()
        
        for var a = 1; a <= 13; ++a {
            var card = Card(number: a, type: cardType.heart, image: "CardHeart\(a)")
            cardPool.append(card)
        }
        
        for var a = 1; a <= 13; ++a {
            var card = Card(number: a, type: cardType.spade, image: "CardSpade\(a)")
            cardPool.append(card)
        }
        
        for var a = 1; a <= 13; ++a {
            var card = Card(number: a, type: cardType.club, image: "CardClub\(a)")
            cardPool.append(card)
        }
        
        for var a = 1; a <= 13; ++a {
            var card = Card(number: a, type: cardType.diamond, image: "CardDiamond\(a)")
            cardPool.append(card)
        }
        
        cardPool.append(Card(number: 14, type: cardType.jocker, image: "JokerS"))
        cardPool.append(Card(number: 14, type: cardType.jocker, image: "JokerS"))
        cardPool.append(Card(number: 15, type: cardType.jocker, image: "Joker"))
        cardPool.append(Card(number: 15, type: cardType.jocker, image: "Joker"))
        
        
        cardPool = cardPool.shuffled()
        
        print("card pool initiated")
        
        //for card in cardPool{ print(card.toString()) }
        //print(cardPool.count)
        
        //card drawing
        var division: Int = cardPool.count/numberOfPlayer;
        for var a = 0; a < numberOfPlayer; ++a {
            var playerCardPool = [Card]()
            for var i = 0; i < division && !cardPool.isEmpty; i++ {
                playerCardPool.append(cardPool.removeLast())
            }
            
            if a == 0 {
                players.append(People(playerType: peopleType.human, cards: playerCardPool, numberOfCards: playerCardPool.count))
            } else {
                players.append(AIPlayer(cards: playerCardPool, numberOfCards: playerCardPool.count))
            }
        }
        
        print(players.count)
        //for people in players{ print("player cardpool **************") for card in people.cards{ print(card.toString()); } }
        
        for player in players{
            player.cards.sortInPlace{ (card1, card2) -> Bool in
                return card1 < card2;
            }
        }
        
        //fill card buttons in the view
        for var a = 0; a < players[0].cards.count ; ++a {
            let cardButton = UIButton(type: UIButtonType.System)
            
            cardButton.setBackgroundImage(UIImage(named: players[0].cards[a].image), forState: UIControlState.Normal)
            var carImageLeftEdge = CGFloat(a) * cardImageWidth
            cardButton.frame = CGRectMake(carImageLeftEdge, cardImageTop, cardImageWidth, cardImageHeight)
            cardButton.backgroundColor = UIColor.clearColor()
            
            cardButton.addTarget(self, action: "cardButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            cardButtons.append(cardButton)
            print("cardButtons.count is \(cardButtons.count)")
            self.view.addSubview(cardButton)
            
        }
    }
    
    func cardButtonClicked(sender:UIButton)
    {
        var buttonIndex = cardButtons.indexOf(sender)
        if(!sender.selected){
            if(cardSetToSubmit.isEmpty){
                cardSetToSubmit.append(players[0].cards[buttonIndex!])
            } else {
                if (!cardSetToSubmit[0].isEqualTo(players[0].cards[buttonIndex!]) ){
                    return
                } else {
                    cardSetToSubmit.append(players[0].cards[buttonIndex!])
                }
            }
        } else {
            for var a = 0; a < cardSetToSubmit.count; ++a{
                if(cardSetToSubmit[a].isEqualTo(players[0].cards[buttonIndex!])){
                    cardSetToSubmit.removeAtIndex(a)
                }
            }
        }
        
        sender.selected = !sender.selected;
    }
    
    func submitButtonClicked(sender:UIButton){
        
        currentHumanPlayerCardSet = geneteCarSetFromCards(cardSetToSubmit)
        
        if(currentTableCardSet.isEmpty() && !currentHumanPlayerCardSet.isEmpty()){
            dealCard()
            cardSetToSubmit = [Card]()
        } else if (!currentHumanPlayerCardSet.isEmpty()) {
            if(currentTableCardSet < currentHumanPlayerCardSet){
                dealCard()
                cardSetToSubmit = [Card]()
            }
        }
    }
    
    func passButtonClicked(sender:UIButton){
        passCount++
        passButton.enabled = true;
        roundStart(1)
    }

    
    func dealCard(){
        currentTableCardSet = CardSet(cardSet: currentHumanPlayerCardSet)
        print(currentHumanPlayerCardSet.cards.count)
        for card in currentHumanPlayerCardSet.cards{
            var cardIndex = players[0].cards.indexOf(card)
            print("cardIndex is \(cardIndex)")
            cardButtons[cardIndex!].selected = false
            cardButtons[cardIndex!].enabled = false
            cardButtons[cardIndex!].setBackgroundImage(UIImage(named: "EmptyCard"), forState: UIControlState.Normal)
            players[0].numberOfCards--
        }
        updatetableCardSetViews(currentTableCardSet)
        submitButton.enabled = false;
        rightToLead = 0
        detectWinner(players[0])
        roundStart(1)
        print(players[0].numberOfCards)
    }
    
    func generateTableCardSetViews() -> [UIImageView]{
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        var tableCardSetViews = [UIImageView]()
        for var a = 0; a <= 3; ++a{
            let image = UIImage(named: "CardBack")
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: screenSize.width/2 + CGFloat(a * 35) - 100, y: screenSize.height/2 - 45 , width: 35, height: 45)
            view.addSubview(imageView)
            tableCardSetViews.append(imageView)
        }
        return tableCardSetViews
    }
    
    func updatetableCardSetViews(tableCardSet: CardSet){
        var sizeOfCardSet = tableCardSet.cards.count
        for var a = 0; a < tableCardSetViews.count; ++a{
            if a < sizeOfCardSet{
                tableCardSetViews[a].image = UIImage(named: tableCardSet.cards[a].image)
            } else {
                tableCardSetViews[a].image = UIImage(named: "EmptyCard")
            }
        }
    }
    
    func gameStart(sender:UIButton){
        
        newGameStart()
        //sender.enabled = false;
        roundStart(rightToLead)

    }
    
    func roundStart(lead: Int){
        
        if passCount >= numberOfPlayer - 1 {
            passCount = 0
            currentTableCardSet = CardSet(type: carSetType.empty, cards: [Card]())
            roundStart(rightToLead)
        }
        
        if(lead == 0 ){
            submitButton.enabled = true;
            passButton.enabled = true;
            return
        }
        //AI move
        for var a = lead; a < numberOfPlayer; ++a{
                var newCardSet = players[a].deal(currentTableCardSet)
                if newCardSet.isEmpty(){
                    print("AI passed")
                    passCount++
                    
                    if passCount >= numberOfPlayer - 1 {
                        passCount = 0
                        currentTableCardSet = CardSet(type: carSetType.empty, cards: [Card]())
                        roundStart(rightToLead)
                    }
                    
                } else {
                    print("AI dealed")
                    detectWinner(players[a])
                    currentTableCardSet = CardSet(cardSet: newCardSet)
                    rightToLead = a
                    updatetableCardSetViews(currentTableCardSet)
                }
        }
        roundStart(0)
    }
    
    func detectWinner(player: People){
        if player.playerType == peopleType.human && player.numberOfCards <= 0 {
            print("Your Win")
            alertController.message = "You Win!"
            self.presentViewController(alertController, animated: true, completion: nil)
            newGameStart()
        }
        if player.playerType == peopleType.AI && player.cards.count <= 0 {
            print("Your Lose")
            alertController.message = "You Lose....."
            self.presentViewController(alertController, animated: true, completion: nil)
            newGameStart()
        }
    }
    
    func backToHomeView(sender: UIButton){
        navigationController?.popViewControllerAnimated(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
