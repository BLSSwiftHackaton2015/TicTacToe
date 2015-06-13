//
//  ViewController.swift
//  TicTacToe
//
//  Created by Robert Kotecki on 13/06/15.
//  Copyright (c) 2015 Hackaton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var board: [Int?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    var currentRound = 0;
    
    var moveInfo: MoveInfo?
    var gameOver = false;
    
    @IBOutlet var debug: UILabel!
    @IBOutlet var gameOverView: UIVisualEffectView!
    @IBOutlet var gameOverWinner: UIImageView!
    
    @IBOutlet var btnResetGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleWatchKitNotification:"), name: "WatchExtensionCom", object: nil)
        
        btnResetGame.layer.cornerRadius = 15
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func hightlightButton(tag: Int, type: Int)
    {
        var pin : UIImage = UIImage(named: (type == 0 ? "os" : "xs"))!
        
        let btn : UIButton? = self.view.viewWithTag(tag+1) as? UIButton
        btn?.setBackgroundImage(pin, forState: UIControlState.Normal)
    }
    
    func highlightLine(a: Int, b: Int, c: Int, type: Int)
    {
        hightlightButton(a, type: type)
        hightlightButton(b, type: type)
        hightlightButton(c, type: type)
    }
    
    func checkLine(a: Int, b: Int, c: Int) -> Int?
    {        
        if( board[a] == nil || board[b] == nil || board[c] == nil)
        {
            return nil;
        }
        
        let sum = board[a]! + board[b]! + board[c]!
        
        switch sum
        {
            case 0: debug.text = "o win";
            case 3: debug.text = "x win";
            
            default: return nil
        }
        
        if let moveInfo = moveInfo {
            debug.text = "Game Over\n" + debug.text!
            
            highlightLine(a, b: b, c: c, type: sum == 0 ? 0 : 1)
            
            var winnerImage : UIImage = UIImage(named: (sum == 0 ? "os" : "xs"))!
            self.gameOverWinner.image = winnerImage;
            self.gameOverView.hidden = false;
            
            self.gameOver = true
            
            let move = ["Tag": sum == 0 ? 1000 : 2000]
            moveInfo.replyBlock(move)
        }
        
        return sum;
    }
    
    func checkBoard()
    {
        // 1,2,3
        // 4,5,6
        // 7,8,9
        
        // 1,4,7
        // 2,5,8
        // 3,6,9
        
        // 1,5,9
        // 3,5,7
        
        checkLine(0, b: 1, c: 2)
        checkLine(3, b: 4, c: 5)
        checkLine(6, b: 7, c: 8)
        
        checkLine(0, b: 3, c: 6)
        checkLine(1, b: 4, c: 7)
        checkLine(2, b: 5, c: 8)
        
        checkLine(0, b: 4, c: 8)
        checkLine(2, b: 4, c: 6)
    }
    
    func handleWatchKitNotification(notification: NSNotification)
    {
        if let userInfo = notification.object as? MoveInfo {
            debug.text = String(userInfo.position!)
            
            let btnTag : Int = userInfo.position! + 1 //
            
            let btn : UIButton? = self.view.viewWithTag(btnTag) as? UIButton
            btn?.setBackgroundImage(UIImage(named: "o"), forState: UIControlState.Normal)
            
            board[userInfo.position!] = 0;
            
            currentRound = 1;
            debug.text = "You turn"
            
            self.moveInfo = userInfo
            
            checkBoard()
        }
    }
    
    @IBAction func touchBoard(sender: AnyObject) {
    
        if(gameOver)
        {
            return
        }
        
        if(currentRound == 0)
        {
            debug.text = "Opponent turn"
            return
        }
        
        println("tag \(sender.tag)");
    
        let btn : UIButton? = self.view.viewWithTag(sender.tag) as? UIButton
        
        let boardTag = sender.tag - 1
        
        if(board[boardTag] == nil)
        {
            board[boardTag] = 1;
            btn?.setBackgroundImage(UIImage(named: "x"), forState: UIControlState.Normal)
        }
        
        currentRound = 0
        
        debug.text = "Opponent turn"
        
        if let moveInfo = moveInfo {
            let move = ["Tag": boardTag]
            moveInfo.replyBlock(move)
        }
        
        checkBoard()
    }
    
    @IBAction func actionResetGame(sender: AnyObject) {
        
        // reset game
        
        gameOverView.hidden = true;
        
        for(var i = 0; i < 9; i++)
        {
            board[i] = nil;
            
            let btn : UIButton? = self.view.viewWithTag(i+1) as? UIButton
            btn?.setBackgroundImage(UIImage(named: "empty"), forState: UIControlState.Normal)
        }
        
        if let moveInfo = moveInfo {
            let move = ["Tag": 9999]
            moveInfo.replyBlock(move)
        }
        
        debug.text = "Opponent turn"
        
        currentRound = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }


}

