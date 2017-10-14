////
//  Player.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class Player {
    var currentUniverse : Universe //Universe the player is currently is in
    var io : GameOutput
    var _health: Int
    var traveled : [Universe] //Stack that will be used in implemnentation of the back command
    var inventory : [Item] //Holds the player's items
    var memories : [MemoryFragment] //Stores teh Memories rhe player gets back
    var maxWeight: Int //Maximum wweight of objects a player can hold
    var coins : Int //Player's money
    var currWeight : Int //current weight of the items stored
    var storyDiag : LinkedQueue<String> //Holds the dialogue for the plaeyr
    var equipped : Item? //The weapon the player will use in combat
    var armored : Item? //The armor the player will use in combat
    
    //var top: Int
    
    

    
    init(univ : Universe, output : GameOutput) { //Initializer
        currentUniverse = univ
        io = output
        _health = 100
        traveled = [Universe]()
        traveled.append(currentUniverse)
        //top = 1
        inventory = [Item]()
        maxWeight = 300
        memories = [MemoryFragment]()
        coins = 80
        currWeight = 0
        storyDiag = LinkedQueue<String>()
        //Dialogue creation
        storyDiag.enqueue("\n Player: Uhhh my head! I remember now. He was from my favorite anime show.")
        storyDiag.enqueue("\n Player: Uhhh my head! I remember now. I-I loved her and I attacked her? The Dark One will pay for this!")
        storyDiag.enqueue("\n Player: Uhhh my head! I remember now. He-He was the scary killer from a horror movie I watched when I was 6. I conqureed my fear.")
        storyDiag.enqueue("\n Player: Uhhh my head! I remember now. I wanted to be a software engineer at one point, so why did I not pursue it")
        storyDiag.enqueue("\n Player: Uhhh my head! I remember now. He was my professor in school. He handed me my degree at graduation.")
        storyDiag.enqueue("\n Player: Uhhh my head! I remember now. I'm a genius. I was top of my class and I had my own lab. Why though?")
        storyDiag.enqueue("\n Player: Uhhh my head! I remember now. I see myself with other people crying as I look down at a tombstone. Who is this?")
        storyDiag.enqueue("\n Player: Uhhh my head! I remember now. I remember mom, my sister, my aunt & uncle, my late grandfather, and you, Dad!")
        storyDiag.enqueue("\n Grant: I won't let you down, dad!")
        storyDiag.enqueue("\n Grant: Uhhh my head! I remember now. I was a scientist and I was testing a device that let me peer into other universe. I saw you trapped in the Negative zone and worked to free you. When I did, I realized that you were me!")
        storyDiag.enqueue("\n Grant: I wont stoop to your level. I may look like you, but we're nothing alike. I won't kill you, I'll imprison you. I use the staff of the Dark Magician to break open the portal to Negative Zone and chain you there.")
        storyDiag.enqueue("\n Grant: Dark Magic Attack!")

        
    }

    
    func walkTo(_ direction : String) { //Let's the player move between universes
        let nc = NotificationCenter.default //Notification center that will be used later
        let portal : Portal? = currentUniverse.getExit(direction) //Retrieves the portal for the designated universe
        
        if portal != nil { //The portal may not exist
            if(portal!.getUnivB().reqMem.count != 0){ //Checks to see whether the arriving Universe needs a cerains memory fragments
                if(memComparison(memories, portal!.getUnivB().reqMem)==true){ //Checks to see if the player has the required memory fragments.
                    portal?.unlock() //If the player does, the portal wll be unlocked
                    }
                    if portal?.isLocked() == false{ //Checks wheter or not the portal is locked
                        let nextUniverse : Universe? = portal?.universe(otherUniverse : currentUniverse) //Retreives the arriving Universe
                        if nextUniverse != nil{
                            nc.post(Notification.init(name: Notification.Name(rawValue: "PlayerWillEnterRoom"), object: nextUniverse!)) //posting a notification
                            traveled.append(nextUniverse!) //Adds the next universed to the traveld stack
                            self.currentUniverse = nextUniverse! //Moves the player to the arriving universe
                            nc.post(Notification.init(name: Notification.Name(rawValue: "PlayerDidEnterRoom"), object: self.currentUniverse)) //posting a notification
                            self.outputMessage("\n\(nextUniverse!.description())") //Upon arrival, the player will be alerted to the Universe he entered.
                            //path.append(nextRoom!)
                        }
                            
                            
                        else{
                            self.errorMessage("\nThe portal to \(direction) is closed")
                        }
                    }
                    else{
                        self.errorMessage("\nThe portal to \(direction) is locked. Required fragments:") //If the portal is locked, the required memory fragments will be displayed
                        for i in 0..<portal!.getUnivB().reqMem.count{
                            self.outputMessage(" \(portal!.getUnivB().reqMem[i])")
                        }
                    }
                
                
            }
            else{
                //If the portal was never locked, then the player can prcceed.
                if portal?.isLocked() == false{
                    let nextUniverse : Universe? = portal?.universe(otherUniverse : currentUniverse)
                    if nextUniverse != nil{
                        nc.post(Notification.init(name: Notification.Name(rawValue: "PlayerWillEnterRoom"), object: nextUniverse!)) //posting a notification
                        traveled.append(nextUniverse!)
                        self.currentUniverse = nextUniverse!
                        nc.post(Notification.init(name: Notification.Name(rawValue: "PlayerDidEnterRoom"), object: self.currentUniverse)) //posting a notification
                        self.outputMessage("\n\(nextUniverse!.description())")
                        //path.append(nextRoom!)
                    }
                        
                        
                    else{
                        self.errorMessage("\nThe portal to \(direction) is closed")
                    }
                }
                else{
                    self.errorMessage("\nThe portal to \(direction) is locked")
                }
            }
        }
        else {
            self.errorMessage("\nThere is no portal to '\(direction)'")
        }
    }
    
    
    func back(){//Method used for the Back Command. Allows the user to go back to he last visited Universe
        if traveled.count == 1{ //If there is only one, then there is no where to go back to
            self.errorMessage("\nThere is no where else to go back to")
        }
        else{
            //top -= 1
            traveled.popLast() //Removes the last element in the stack as it is the Universe the player is currently is in
            self.currentUniverse = traveled[traveled.count-1] //Goes to the the last Universe in the stack which is not the last visted Universe
            self.outputMessage("\n\(self.currentUniverse.description())")
            
        }
    }
    
    func equip(_ tag : String){ //Fucntion used for the Equip Commanf. Allows the user to equip a weapon for combat
        for i in 0..<inventory.count{
            if(inventory[i].name == tag){
                equipped = inventory[i]
                outputMessage("\n Weapon equipped")
            }
        }
        if equipped == nil{
            outputMessage("No such item in inventory")
        }
    }
    
    func sumWeight() -> Int{ //Returns the summation of the weight of all the items in the inventory
        var sum = 0
        for i in 0..<inventory.count{
            sum += inventory[i].weight
        }
        return sum
    }
    func pickup(_ tag : String){//Function used for the Pickup Command. Allows the player to pickup an item
        if(currentUniverse.tag != "at the Market"){
            var existence = 0
            var index = 0
            for i in 0..<currentUniverse.availableItems.count{
                if(currentUniverse.availableItems[i].name == tag){
                    existence = 1
                    index = i
                }
            }
            if(existence == 0){
                outputMessage("\n No such item in this universe")
            }
            else{
                if (currentUniverse.availableItems[index].weight + sumWeight() < maxWeight){
                    outputMessage("\n You have accquired \(currentUniverse.availableItems[index].description())")
                    currWeight += currentUniverse.availableItems[index].weight
                    inventory.append(currentUniverse.availableItems.remove(at: index))
                }
                else{
                    outputMessage("\n Adding item will exceed the maximum weight you can carry. Item dropped in this Universe")
                    
                }
            }
            
        }
        else{
            outputMessage("\n You are not allowed to pick up items in the Market. You must buy them first")
        }
    }
    
    func dropItem(_ tag : String){//Function used for the Pickup Command. Allows the player to drop an item
        for i in 0..<inventory.count{
            if(inventory[i].name == tag){
                outputMessage("\n You have dropped a \(inventory[i].name)")
                currentUniverse.availableItems.append(inventory.remove(at: i))
            }
            else{
                outputMessage("There is no such item here to drop")
            }
        }

    }
    
    func displayUniverseItems(){//Displays the all the items in the current Universe
        if(currentUniverse.availableItems.count > 0){
        for i in 0..<currentUniverse.availableItems.count{
            outputMessage("\n \(currentUniverse.availableItems[i].name)")
        }
        }
        else{
            outputMessage("\n No items in this Universe")
        }
    }
    
    func displayNPCItems(){//Displays the items the NOC has
        for i in 0..<currentUniverse._npc!.inventory.count{
            outputMessage("\n \(currentUniverse._npc!.inventory[i].name) : price - \(currentUniverse._npc!.inventory[i].value) ")
        }
    }
    func displayMemories(){ //Displays the memories currently held by the plaer
        if(memories.count == 0){
            outputMessage("\n You have not recovered any memories yet")
        }
        else{
            outputMessage("\n Fragments Collected:")
            for i in 0..<memories.count{
                outputMessage("\n \(memories[i]._title)")
            }
        }
    }
    func viewInventory(){ //Displays the invetory of the player
        if (inventory.isEmpty == true){
            outputMessage("\n Your inventory is empty")
            outputMessage("\n Coins : \(coins)")
        }
        else{
        for i in 0..<inventory.count{
            outputMessage("\n \(inventory[i].description()) Weight: \(inventory[i].weight) Value : \(inventory[i].value) ")
        }
        displayMemories()
        outputMessage("\n Coins : \(coins)")    
        }
    }
    
    func memoryAcquired(_ memory : MemoryFragment){ //Add a memory fragment to to the player's array of memories
        memories.append(memory)
        outputMessage("\n You have acquired \(memory._title). It represents your \(memory._descripion)")
    }
    
    func battle(_ name : String){ //Function used for the Battle Command
        if (currentUniverse._npc != nil ){  //Universe may not have a NPC
            if (currentUniverse._npc!.name == name){ //Checks whether the given name is the name of the universe's NPC
                if((currentUniverse._npc!.name == "John") || (currentUniverse._npc!.name == "Merchant")){ //Makes sure the NPCs battling are not friendly
                    outputMessage("\n \(name) is not a hostile. No battle need")
                }
                else{
                  let command = NPCCommand(currentUniverse._npc!) //Makes the NPC get their weapon ready
                  command.battleReady()
                    if(equipped == nil){ //Checks to make sure the the player's weapon is equipped
                        errorMessage("\n You must equip a weapon before battle. Use the word equip and the name of your weapon")
                    }
                    else{
                        //outputMessage(currentUniverse._npc!.dialogue.dequeue()!)
                        if(name == "Dark One"){ //Final Dialogue for the Boss character
                            outputMessage("\n Dark One: So we finally meet again. Yes we've met before, but perhaps you don't remmeber. Here's the actual final memory fragment. Let's begin the final battle")
                            outputMessage("\n Grant: Uhhh my head! I remember now. I was a scientist and I was testing a device that let me peer into other universe. I saw you trapped in the Negative zone and worked to free you. When I did, I realized that you were me!")
                        }
                        else{
                            outputMessage(currentUniverse._npc!.dialogue.dequeue()!) //Removes the first line if dialogue for the NPC in case the player didnt speak to the NPC before battle
                        }
                        defense() //Sets the player's armor
                        while(currentUniverse._npc!.health>0){ //Battling will continue as long as the NPC has health
                            let NPCMode = Int(arc4random_uniform(UInt32(2))) //Each iteration will see the player either defending or striking
                            if(NPCMode == 1){ //Player Strikes
                                outputMessage("\n \(currentUniverse._npc!.name) defends. You strike.")
                                strike() //Decreases NPC'S health
                                if(currentUniverse._npc!.health >= 0){
                                    outputMessage("\n Current health: \(_health)  Dark Magician: \(currentUniverse._npc!.health)")
                                }
                                else{
                                     outputMessage("\n Current health: \(_health)  \(currentUniverse._npc!.name): 0") //In case the NPCS health reaches below 0, health must equal 0
                                }
                                
                            }
                            else{
                                //Anything not 1. NPC Strikes
                                if(_health - currentUniverse._npc!.equipm.hitPoints > 0){ //NPC can striike, so long as stike won't put the health below 0.
                                if(armored == nil){ //There may not be armor
                                    _health -= currentUniverse._npc!.equipm.hitPoints //Without armor health will be depleted
                                    outputMessage("\n Defending")
                                    outputMessage("\n Current health: \(_health)  \(currentUniverse._npc!.name): \(currentUniverse._npc!.health)")
                                }
                                else{
                                    //If there is armor, it will be decreased instead
                                    armored!.armorDec(currentUniverse._npc!.equipm.hitPoints)
                                    if(armored!.defense > 0 ){
                                        outputMessage("\n \(currentUniverse._npc!.name) striked.")
                                        outputMessage("\n Armor points: \(armored!.defense) left.")
                                    }
                                    else{
                                        //Once armor loses all its defense points, it will be worn out and destroyed
                                        outputMessage("\n \(currentUniverse._npc!.name) striked.")
                                        outputMessage("\n Armor points: 0. Armor worn out and destroyed")
                                        for i in 0..<inventory.count{
                                            if(inventory[i].name == armored!.name){
                                                inventory.remove(at: i)
                                                break
                                            }
                                
                                        }
                                        armored = nil
                                    }
                                }
                              }
                            else{
                                    //Before teh player runs out of health, he will be turn the battle around
                                    outputMessage("\n \(currentUniverse._npc!.name) defends. You strike.")
                                    strike()
                                    if(currentUniverse._npc!.health >= 0){
                                        outputMessage("\n Current health: \(_health)  \(currentUniverse._npc!.name): \(currentUniverse._npc!.health)")
                                    }
                                    else{
                                        outputMessage("\n Current health: \(_health)  \(currentUniverse._npc!.name) : 0")
                                    }
                                }
                            }
                        }
                        
                        //Condition is made for all NPCS that have less than 2 lines of dialogue. Once the NPC is defeated, their final piece of dialogue will be
                        //displayed, thier memory fragement(if they have one) will be given to the player, their weapon will be given to the player, and coins will
                        //be given
                        if(currentUniverse._npc!.dialogue.size == 1){
                        outputMessage(currentUniverse._npc!.dialogue.dequeue()!)
                        if(currentUniverse._npc!.stolenMem != nil){
                                memoryAcquired(currentUniverse._npc!.stolenMem!)
                                currentUniverse._npc!.stolenMem = nil
                            }
                        currentUniverse.insertItem(currentUniverse._npc!.equipm)
                        pickup(currentUniverse._npc!.equipm.name)
                        outputMessage(storyDiag.dequeue()!)
                        currentUniverse._npc = nil
                        _health = 100
                        }
                        else{
                            //Dialogue for the final boss
                            outputMessage("\n Dark One: Yes I am you from the universe where you met Grimm. My life is nothing but pain and anguish there. When I finally acheived something with my machine, I get trapped in the Negative Zone. Then you rescue me and I see your life. A perfect life. It makes me mad!")
                            outputMessage("\n Dark One: Do it finish me off!")
                            outputMessage("\n Grant: I wont stoop to your level. I may look like you, but we're nothing alike. I won't kill you, I'll imprison you. I use the staff of the Dark Magician to break open the portal to Negative Zone and chain you there.")
                            outputMessage("\n Dark One: No please.")
                            outputMessage("\n Grant: Dark Magic Attack!")
                            outputMessage("\n Dark One: Noooo!!!!")
                            let nc = NotificationCenter.default
                            if(currentUniverse._npc!.health <= 0){
                                outputMessage("\n The Dark One has been defeated. You've won!")
                                nc.post(Notification.init(name: Notification.Name(rawValue: "BossDied"), object: self.currentUniverse))
                                //notifcation that will end the game once the final boss' health will be depleted
                            }
                        }
                    }
                }
            }
        }
    }
    func defense(){ //Equips armors
        var existence = 0
        var highest = 0
        var index = 0
        for i in 0..<inventory.count{ //Checks if tthere is any armor in the inventory
            if(inventory[i].defense>0){
                existence = 1
            }
            if(inventory[i].defense > highest){ //Finds armor with th highest defense points
                highest = inventory[i].defense
                index = i
            }
        }
        if(existence == 0){ //If none exists, this message will be displayed
            outputMessage("\n No armor to equip")
        }
        else{ //If it does, the armor will be equipped
            armored = inventory[index]
            outputMessage("\n \(armored!.name) equipped.")
        }
    }
    func strike(){ //Decreases an NOC's health
        currentUniverse._npc!.health -= equipped!.hitPoints
    }

    func speak(_ charc: String){ //Function used for the Speak Command
        if (charc == currentUniverse._npc!.name){ //Checks to see whether the given name is name of current universe's npc
            if(charc == "John"){ //Since Johb has more than 1 line of dialogue, it will need to be displayed all at once
                outputMessage(currentUniverse._npc!.dialogue.dequeue()!)
                memoryAcquired(currentUniverse._npc!.stolenMem!)
                currentUniverse._npc!.stolenMem = nil
                outputMessage(storyDiag.dequeue()!)
                outputMessage(currentUniverse._npc!.dialogue.dequeue()!)
                outputMessage(storyDiag.dequeue()!)
            }
            else{
                if(charc == "Dark One"){
                outputMessage("\n Dark One: So we finally meet again. Yes we've met before, but perhaps you don't remmeber. Here's the actual final memory fragment. Let's begin the final battle")
                }
                else{
                //Shows the wlcome message of each NPC
                outputMessage(currentUniverse._npc!.dialogue.peek())
                }
            }
        }
        else{
            errorMessage("\n \(charc) does not exist.")
        }
    }
    
    func purchase(_ tag : String){ //Function used for Purchase Command
        var item : Item
        if(currentUniverse._npc?.name == "Merchant"){ //Checks to make sure the player is in the Market
            
            for i in 0..<currentUniverse._npc!.inventory.count{ //Finds the rquested item
                if (currentUniverse._npc!.inventory[i].name == tag){
                    item = currentUniverse._npc!.inventory[i]
                    if (item.weight + sumWeight() <= maxWeight){
                        currWeight += item.weight //Increases teh current weight of the items
                        coins -= item.value //Takes away the amount of coins needed for the item
                        currentUniverse._npc!.coins += item.value //Gives those coins to the Merchant
                        outputMessage("\n You have acquired: \(item.name)")
                        inventory.append(item)
                    }
                    else{
                        errorMessage("\n Purchasing item will go over max weight. Considering dropping some items")
                    }
                    break
                }
            }
        }
        else{
            errorMessage("\n Purchasees may only take place in the Market with the Merchant")
        }
    }
    
    func sell(_ tag : String){ //Fucntion used for Sell Command
        var item : Item
        //outputMessage("\n Test")
        if(currentUniverse._npc?.name == "Merchant"){ //Checks to make sure the player is in the Market
            for i in 0..<inventory.count{ //Locates the item to sale
                if (inventory[i].name == tag){
                    item = inventory.remove(at: i) //Removes the item from the inventory
                    currWeight -= item.weight //Removes the weight
                    coins += item.value //Gives equal to the removed items value to the player
                    currentUniverse._npc!.coins -= item.value //Takes away those coins from the mercahnt
                    outputMessage("\n You have acquired: \(item.value) coins")
                    currentUniverse._npc!.inventory.append(item)
                }
            }
        }
        else{
            errorMessage("\n Purchasees may only take place in the Market with the Merchant")
        }
    }
    //Function ussed to check if the required memory fragments are in the player's memories array
    func memComparison(_ mem1 : [MemoryFragment],_ mem2 : [String])->Bool{
        var matches = 0
        let allThere = true
        for i in 0..<mem2.count{
            for j in 0..<mem1.count{
                if(mem2[i] == mem1[j]._title){
                    matches += 1
                }
            }
        }
        if(matches == mem2.count){
            return allThere
        }
        else{
            return !allThere
        }
    }
    
    func outputMessage(_ message : String) {
        io.sendLine(message)
    }
    
    func outputMessage(_ message : String, color : NSColor) {
        let lastColor : NSColor = io.currentColor
        io.currentColor = color
        self.outputMessage(message)
        io.currentColor = lastColor
    }
    
    func errorMessage(_ message : String) {
        self.outputMessage(message, color: NSColor.red)
    }
    
    func warningMessage(_ message : String) {
        self.outputMessage(message, color: NSColor.orange)
    }
    
    func commandMessage(_ message : String) {
        self.outputMessage(message, color: NSColor.brown)
    }
    
   
}
