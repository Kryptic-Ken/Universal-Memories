//
//  Back.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/20/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class BackCommand: Command {
    override init() {
        super.init()
        self.name = "back"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.warningMessage("\n Can only go back to the last visited room")
        } else {
            player.back()
        }
        return false
    }
}
