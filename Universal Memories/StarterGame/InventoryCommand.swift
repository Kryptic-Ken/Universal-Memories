//
//  InventoryCommand.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/25/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class InventoryCommand: Command {
    override init() {
        super.init()
        self.name = "inventory"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.warningMessage("\n Only the word Inventory is necessary")
        } else {
            player.viewInventory()
        }
        return false
    }
}
