//
//  ViewController.swift
//  Winner(Card Game)
//
//  Created by Jia Liu on 11/12/15.
//  Copyright © 2016 Jia Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        StartButton.setBackgroundImage(UIImage(named:"NewGameBtn"), forState: UIControlState.Normal)
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "LandscopeBackGround")
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var StartButton: UIButton!
    
    

}


