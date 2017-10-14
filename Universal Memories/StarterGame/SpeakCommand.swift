//
//  SpeakCommand.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 5/3/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation


class SpeakCommand: Command {
    override init() {
        super.init()
        self.name = "speak"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.speak(secondWord!)
        } else {
            //player.warningMessage("No Item was specified")
            //player.speak()
            //player.displayUniverseItems()
            player.warningMessage("\n No character was specified")
        }
        return false
    }
}
