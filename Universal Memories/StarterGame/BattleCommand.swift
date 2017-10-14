//
//  BattleCommand.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 5/3/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class BattleCommand: Command {
    override init() {
        super.init()
        self.name = "battle"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.battle(secondWord!)
        } else {
            player.warningMessage("\n No Character was specified")
        }
        return false
    }
}
