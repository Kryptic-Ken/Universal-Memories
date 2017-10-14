//
//  CommandWords.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class CommandWords {
    var commands : [String : Command]
    
    convenience init() {
        self.init(commandList: [GoCommand(), QuitCommand(),BackCommand(),InventoryCommand(),PickupCommand(),DropCommand(),SpeakCommand(),BattleCommand(),PurchaseCommand(),SellCommand(),EquipCommand()])
    }
    
    init(commandList : [Command]) {
        commands = [String : Command]()
        for command in commandList {
            commands[command.name] = command
        }
        let help : HelpCommand = HelpCommand(commands: self)
        commands[help.name] = help
    }
    
    func get(_ word : String) -> Command? {
        return commands[word]
    }
    
    func description() -> String {
        return commands.keys.joined(separator: " ")
    }
}
