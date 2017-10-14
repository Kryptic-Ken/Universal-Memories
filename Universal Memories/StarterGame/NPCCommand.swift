//
//  NPCBattle.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/27/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class NPCCommand{//Impelementation of the Comamand Patern. Player can call this command when they enter the battle command
    var _npc : NPC
    
    init(_ npc: NPC){
        _npc = npc
    }
    
    func battleReady(){//Makes the opposing NPC equip his weapon
        _npc.equipB()
    }
}
