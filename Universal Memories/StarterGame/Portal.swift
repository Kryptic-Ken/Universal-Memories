//
//  Door.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/20/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class Portal : Lockable{//Creates a portal between Universes
    private var _univA : Universe //1st Universe linked to the portal
    private var _univB : Universe //2nd Universe linked to door
    private var _lock : Bool //This will be the lock for the portal, so the player cant access locations until he obtains memories
    var lockN : Bool{ //getter and setter for loc
        get{
            return _lock
        }
        set {
            _lock = newValue
        }
    }
    init(univA : Universe, univB : Universe){ //Initializer
        _univA = univA
        _univB = univB
        _lock = false//Portals will be unlocked initially unless the need to be locked
    }
    
    func universe(otherUniverse : Universe) -> Universe{ //When passig through a portal, this method returns the Universe on the other side of the portal
        if (otherUniverse === _univA){
            return _univB
        }
            
        else{
            return _univA
        }
    }
    func getUnivA() -> Universe{ //Returns the leaving Universe
        return _univA
    }
    func getUnivB() -> Universe{ //Returns the arriving Universe
        return _univB
    }
    func lock(){//Locks the portal
        _lock = true
    }
    func unlock(){//Unlock the portal
        _lock = false
    }
    func isLocked()->Bool{ //Determines wheter or not a portal is locked
        return _lock
    }
}
func connect(firstU : Universe, secondU: Universe, firstLabel: String, secondLabel : String) -> Portal { //Creates the portal between two Universes
    let portal : Portal = Portal (univA: firstU, univB: secondU)
    firstU.setExit(secondLabel, portal : portal)//Using the sexExit functon from the Universe class we set the portal as the exit for the two Universes passed
    secondU.setExit(firstLabel, portal: portal)
    return portal
}


//Fasad pattern idea connect regular lock which locks and uses connect
