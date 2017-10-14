//
//  PickUpCommand.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/25/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class PickupCommand: Command {
    override init() {
        super.init()
        self.name = "pickup"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.pickup(secondWord!)
        } else {
            player.warningMessage("\nNo Item was specified")
            player.displayUniverseItems()
        }
        return false
    }
}
