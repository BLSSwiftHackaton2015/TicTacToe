//
//  MenuController.swift
//  TicTacToe
//
//  Created by Robert Kotecki on 13/06/15.
//  Copyright (c) 2015 Hackaton. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    @IBOutlet var btnStartGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btnStartGame.layer.cornerRadius = 15
    }
    
}