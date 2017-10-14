//
//  PurchaseCommand.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 5/3/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation


class PurchaseCommand: Command {
    override init() {
        super.init()
        self.name = "purchase"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.purchase(secondWord!)
        } else {
            if(player.currentUniverse._npc?.name == "Merchant"){
            player.displayNPCItems()
            player.warningMessage("\n Select an item when you enter purchase")
            }
            else{
            player.warningMessage("\n Purchases can only occur in the Market")
            }
        }
        return false
    }
}
