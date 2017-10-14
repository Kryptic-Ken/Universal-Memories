//
//  EquipCommand.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 5/7/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class EquipCommand: Command {
    override init() {
        super.init()
        self.name = "equip"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.equip(secondWord!)
        } else {
            player.warningMessage("\n No Item was specified")
            player.viewInventory()
        }
        return false
    }
}
