//
//  Room.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class Universe: UniverseProtocol {
    var portals : [String : Portal]//Portals that will connect to the other Universes
    var tag : String //Name of the Universe
    var availableItems: [Item] //Items stored in the Universe
    var _npc : NPC? //Optional NPC character. A universe may not have a character
    var reqMem : [String]//This array will store the title of the memory fragment required to neter the Universe. The fragment acts as a key to enter the Universe
    
    
    convenience init() {
        self.init(tag: "No Tag")
    }
    
    init(tag : String ) { //initializer
        //exits = [String : Room]()
        portals = [String : Portal]()
        self.tag = tag
        availableItems = [Item]()
        reqMem = [String]()

    }
    
    func addCharacter(_ npc : NPC){ //Inserts a character into the Universe
        if(_npc == nil){
        _npc = npc
        }
        else{
            _npc = npc
        }
    }
    
    func insertItem(_ item : Item?){ //Inserts an item into the Universe
        if (item != nil){
            availableItems.append(item!)
        }
    }
    
    
    
    func setExit(_ exitName : String, portal : Portal) { //Sets a portal to be an exit that will lead to another universe
        
            portals[exitName] = portal
        
    }
    
    func getExit(_ exitName : String) -> Portal? { //Retreives a portal if one exits to another Universe
            return portals[exitName]
        
    }
    
    func getExits() -> String { //Used in the console window to inform the user of the available exits
            let exitNames : [String] = [String](portals.keys)
            return "Exits: " + exitNames.joined(separator: " ")
        
    }
    
    func description() -> String {//Informs the user of the Universe they are currently in
            return "You are \(tag).\n *** \(self.getExits())\n"

    }
    
    deinit {
        tag = ""
        portals.removeAll()
    }


}



