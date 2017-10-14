//
//  DropCommand.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/25/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class DropCommand: Command {
    override init() {
        super.init()
        self.name = "drop"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.dropItem(secondWord!)
        } else {
            player.warningMessage("\n No Item was specified")
        }
        return false
    }
}
