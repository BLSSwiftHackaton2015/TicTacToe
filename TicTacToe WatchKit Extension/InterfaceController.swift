//
//  InterfaceController.swift
//  TicTacToe WatchKit Extension
//
//  Created by Robert Kotecki on 13/06/15.
//  Copyright (c) 2015 Hackaton. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var btnLeftTop: WKInterfaceButton!
    @IBOutlet var btnTop: WKInterfaceButton!
    @IBOutlet var btnRightTop: WKInterfaceButton!
    
    @IBOutlet var btnLeft: WKInterfaceButton!
    @IBOutlet var btnCenter: WKInterfaceButton!
    @IBOutlet var btnRight: WKInterfaceButton!
    
    @IBOutlet var btnLeftBottom: WKInterfaceButton!
    @IBOutlet var btnBottom: WKInterfaceButton!
    @IBOutlet var btnRightBottom: WKInterfaceButton!
    
    @IBOutlet var labelMsg: WKInterfaceLabel!
    
    var gameOver = false;
    var currentRound = 0;
    
    @IBAction func actionBtnLeftTop() {
        touchBoard(0);
    }
    
    @IBAction func actionBtnTop() {
        touchBoard(1);
    }

    @IBAction func actionBtnRightTop() {
        touchBoard(2)
    }
    
    @IBAction func actionLeft() {
        touchBoard(3)
    }
    
    @IBAction func actionCenter() {
        touchBoard(4)
    }
    
    @IBAction func actionRight() {
        touchBoard(5)
    }

    @IBAction func actionLeftBottom() {
        touchBoard(6)
    }
    
    @IBAction func actionBottom() {
        touchBoard(7)
    }
    
    @IBAction func actionRightBottom() {
        touchBoard(8)
    }
    
    func getDataFromParentApp(Tag: Int) {
        
        WKInterfaceController.openParentApplication(["Tag": Tag],
            reply: {(reply, error) -> Void in
                println("reply \(reply)")
                
                switch (reply?["Tag"] as? Int, error) {
                    case let (tag, nil) where tag != nil:
                        
                        switch tag!
                        {
                            case 1000:
                                
                                self.labelMsg.setText("o win")
                                self.gameOver = true
                            
                                self.presentControllerWithName("oswin", context: nil)
                            
                            case 2000:
                                
                                self.labelMsg.setText("x win")
                                self.gameOver = true
                            
                                self.presentControllerWithName("xswin", context: nil)
                            
                            case 9999:
                            
                                self.currentRound = 0
                                self.gameOver = false
                            
                                
                                self.btnLeftTop.setEnabled(true)
                                self.btnLeftTop.setBackgroundImage(nil)
                                
                                self.btnTop.setEnabled(true)
                                self.btnTop.setBackgroundImage(nil)
                                
                                self.btnRightTop.setEnabled(true)
                                self.btnRightTop.setBackgroundImage(nil)
                                

                                
                                self.btnLeft.setEnabled(true)
                                self.btnLeft.setBackgroundImage(nil)

                                self.btnCenter.setEnabled(true)
                                self.btnCenter.setBackgroundImage(nil)

                                self.btnRight.setEnabled(true)
                                self.btnRight.setBackgroundImage(nil)

                                
                                
                                self.btnLeftBottom.setEnabled(true)
                                self.btnLeftBottom.setBackgroundImage(nil)

                                self.btnBottom.setEnabled(true)
                                self.btnBottom.setBackgroundImage(nil)

                                self.btnRightBottom.setEnabled(true)
                                self.btnRightBottom.setBackgroundImage(nil)
                            
                                
                                self.labelMsg.setText("You Turn")                                                        
                            
                            default:
                                
                                self.opponentRound(tag!)
                        }
                    case let (_, .Some(error)):
                        println("got an error: \(error)") // take corrective action here
                    default:
                        println("no error but didn't get data either...") // unexpected situation
                }
        })
    }
    
    func opponentRound(Tag: Int)
    {
        drawBoard(Tag, Round: 1)
        currentRound = 0
        
        labelMsg.setText("You Turn")
    }
    
    func drawBoard(Tag :Int, Round: Int)
    {
        var pin : UIImage = UIImage(named: (Round == 0 ? "o" : "x"))!
        var btn : WKInterfaceButton;
        
        switch Tag
        {
            case 1: btn = btnTop
            case 2: btn = btnRightTop
                
            case 3: btn = btnLeft
            case 4: btn = btnCenter
            case 5: btn = btnRight
                
            case 6: btn = btnLeftBottom
            case 7: btn = btnBottom
            case 8: btn = btnRightBottom
                
            default: btn = btnLeftTop // default = 0
        }
        
        btn.setBackgroundImage(pin)
        btn.setEnabled(false);
    }
    
    func touchBoard(Tag :Int)
    {
        if(gameOver)
        {
            return
        }
        
        if(currentRound == 1)
        {
            return
        }
        
        println("tag \(Tag)");        
        
        drawBoard(Tag, Round: currentRound)
        getDataFromParentApp(Tag)
        
        currentRound = 1
        
        labelMsg.setText("Opponent Turn")
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
