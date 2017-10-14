//
//  SellCommand.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 5/3/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class SellCommand: Command {
    override init() {
        super.init()
        self.name = "sell"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.sell(secondWord!)
        } else {
            if(player.currentUniverse._npc?.name == "Merchant"){
                player.viewInventory()
                player.warningMessage("\n Select an item when you enter sell")
            }
            else{
                player.warningMessage("\n Sells can only occur in the Market")
            }
        }
        return false
    }
}
