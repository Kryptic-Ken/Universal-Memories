//
//  NPC.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/20/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation


class NPC{
    var name : String //Name of the NPC
    var health: Int //Health value of the NPC
    //var io : GameOutput
    var inventory: [Item]//Array will hold all of the items the character will in game
    private var equip : Weapon //This will be the weapon the the npc uses in combat
    var stolenMem: MemoryFragment?//NPCS will hold memory fragments and will release them to player upon defeat
    var dialogue: LinkedQueue<String>//Linked queue that stores the dialogue for NPCS
    var coins : Int //Coins storeed by the NPC
    var equipm : Weapon{ //getter and setter for the equip variable
        get{
            return equip
        }
        set{
            equip = newValue
        }
    }
    init(_ healthH: Int, _ nameN : String,_ coin : Int ){ //Initializer
        name = nameN
        health = healthH
        inventory = [Item]()
        equip = Weapon()
        dialogue = LinkedQueue<String>()
        coins = coin
    }
    
    func addItem(_ item : Item?){ //Inserts an Item into inventory
        if(item != nil){
            inventory.append(item!)
        }
        else{
            //player.outputMessage()
        }
    }
    func memory(_ mem : MemoryFragment){ //Gives a memory fragment for the NPC to hold on too
        stolenMem = mem
    }
    func equipB(){//Finds the weapon with the highest hitPoint values and equips it for combat
        var index : Int = 0
        var highest : Int = 0
        for i in 0..<inventory.count{
            let w = inventory[i] as! Weapon
            if(w.hitPoints > highest){
                highest = w.hitPoints
                index = i
            }
            
            }
        equip = inventory[index] as! Weapon
        }
    }
    

