//
//  Protocols.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/20/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

protocol UniverseProtocol { //Protocol for Universes
    func setExit(_ exitName : String, portal : Portal)
    func getExit(_ exitName : String) -> Portal?
    func getExits() -> String
    func description() -> String
    //func setContainer(_ containerRoom : Universe)
}


protocol Item{ //Item protocol. This allows an Item invetory to store items such as weaopons or armors
    var name : String {//Name  of teh weapon
        get}
    var value : Int {//Selling/Buying price
        get set}
    func decorate(decorator : Item)//Implementation of the Decorator Pattern. The patterna allow to upgrade a weapon like a sword to flame sword
    var hitPoints : Int {//Damage points for a weapon
        get}
    var weight : Int {//weight of the item
        get set}
    var defense: Int{//If the item armor then it will have defense points
        get set}
    var itemID: Int{
        get set
    }

    //func cost()->Int
    //func weightD()->Int
    func description()->String//Method to return a brief description of the item
    func armorDec(_ dec : Int)//Used for armor to decrease its defense points while in combat
}


protocol Lockable{ //Protocol to lock things such as portal
    func lock()
    func unlock()
    func isLocked()->Bool

}
