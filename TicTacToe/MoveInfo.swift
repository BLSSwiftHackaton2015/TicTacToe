//
//  MoveInfo.swift
//  TicTacToe
//
//  Created by Robert Kotecki on 13/06/15.
//  Copyright (c) 2015 Hackaton. All rights reserved.
//

import Foundation
import UIKit

class MoveInfo: NSObject {
    
    let replyBlock: ([NSObject : AnyObject]!) -> Void
    var position: Int?
    
    init(userInfo: [NSObject : AnyObject], reply: ([NSObject : AnyObject]!) -> Void) {
        if let userInfo = userInfo as? [String : Int] {
            switch (userInfo["Tag"]) {
                case let (.Some(tag)):
                    position = tag
                default:
                    position = 0
            }
        } else {
            position = 0
        }
        
        replyBlock = reply
    }
}
