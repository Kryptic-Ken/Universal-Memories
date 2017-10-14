//
//  MemoryFragment.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/30/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class MemoryFragment{//Memory Fragemnts will act as keys to the portals between Universe. They also play a role in story as the player will need to recover his memories to find out who he is
    var _title :String //Name of the Fragment
    var _descripion: String//Tells what this Fragment pertains to
    init(_ title : String,_ descrip: String) {//Initializer
        _title = title
        _descripion = descrip
    }
    
    func description()->String{//Returns a description of what this fragment pertains to.
        return _descripion
    }
}
