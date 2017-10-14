//
//  Game.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class Game {
    var player : Player?
    var parser : Parser
    var playing : Bool
    
    init(gameIO : GameOutput) {
        playing = false
        parser = Parser(newCommands: CommandWords())
        player = Player(univ: createWorld(), output: gameIO)
        let nc = NotificationCenter.default
        nc.addObserver(forName: Notification.Name(rawValue: "PlayerWillEnterRoom"), object: nil, queue: nil, using: playerWillEnterRoom)
        nc.addObserver(forName: Notification.Name(rawValue: "BossDied"), object: nil, queue: nil, using: bossNPC)
    }
 
    func createWorld() -> Universe {
        //Creation of the Memories
        let mem = MemoryFragment("Fragement 1", "Interests")
        let mem2 = MemoryFragment("Fragement 2", "Love")
        let mem3 = MemoryFragment("Fragement 3", "Fears")
        let mem4 = MemoryFragment("Fragement 4", "Dreams")
        let mem5 = MemoryFragment("Fragement 5", "Accomplishments")
        let mem6 = MemoryFragment("Fragement 6", "Intelligence")
        let mem7 = MemoryFragment("Fragement 7", "Pain")
        let mem8 = MemoryFragment("Fragement 8", "Family")
        //Creation of the Universes
        let midway = Universe(tag: "in Midway")
        let universe1 = Universe(tag: "in Universe 1")
        let universe2 = Universe(tag: "in Universe 2")
        let universe3 = Universe(tag: "in Universe 3")
        let universe4 = Universe(tag: "in Universe 4")
        let universe5 = Universe(tag: "in Universe 5")
        let universe6 = Universe(tag: "in Universe 6")
        let universe7 = Universe(tag: "in Universe 7")
        let universe8 = Universe(tag: "in Universe 8")
        let universe9 = Universe(tag: "in The Dark One's Palace")
        let universe10 = Universe(tag: "in the Negative Zone")
        let universe11 = Universe(tag: "in an Unkown World")
        let universe12 = Universe(tag: "at the Market")
        
        
        //Gives each Universe a required memory fragment that the player will need to enter
        universe2.reqMem.append(mem._title)
        universe3.reqMem.append(mem2._title)
        universe4.reqMem.append(mem3._title)
        universe5.reqMem.append(mem4._title)
        universe6.reqMem.append(mem5._title)
        universe7.reqMem.append(mem6._title)
        universe8.reqMem.append(mem7._title)
        universe9.reqMem.append(mem._title)
        universe9.reqMem.append(mem2._title)
        universe9.reqMem.append(mem3._title)
        universe9.reqMem.append(mem4._title)
        universe9.reqMem.append(mem5._title)
        universe9.reqMem.append(mem6._title)
        universe9.reqMem.append(mem7._title)
        universe9.reqMem.append(mem8._title)
        
        //Following lines creates a character, gives them dialogue, places them in a certain universe, and adds a weapon to the character
        
        let character1 : NPC = NPC(100, "Dark Magician",20)
        character1.dialogue.enqueue("\n Dark Magician: Welcome to my domain. In this universe fiction is nonfiction here. Now if you want your memory. Fight me!")
        character1.dialogue.enqueue("\n Dark Magician: Blasted I lost. You may take your memory, as well as my weapon. Farewell")
        universe1.addCharacter(character1)
        let m = Weapon("staff", 30,50,40)
        m.decorate(decorator: WeaponDecorator("magic", 20,10,10))
        universe1._npc?.addItem(m)
        let character2 : NPC = NPC(200, "Ophelia",20)
        character2.dialogue.enqueue("\n Ophelia: Nice to see you again darling. In this universe your emotions are personified into beings. If you defeat me, you shall get your memory back ")
        character2.dialogue.enqueue("\n Ophelia: Dont worry I am merely a personification of your love. The real Ophelia is safe in your Universe for now. Now take the memory & my weapon and leave. Farewell")
        universe2.addCharacter(character2)
        let c = Weapon("chaos sceptor", 20,45,40)
        universe2._npc?.addItem(c)
        let character3 : NPC = NPC(300, "Eidolon",20)
        character3.dialogue.enqueue(" \n Eidolon: Now its just you, me, and this sickle. The previous uinverse you encountered your love personified. In this one, I am your fear personified. Can you conquer your fear for your memory?")
        character3.dialogue.enqueue(" \n Eidolon: Ahhhhh. You've defeated me, but I'm just a warmup compared to the Dark One. YOu won't defeat him")
        universe3.addCharacter(character3)
        let t = Weapon("Sickle", 30,30,10)
        universe3._npc?.addItem(t)
        let character4 : NPC = NPC(400, "Technomancer",50)
        character4.dialogue.enqueue(" \n Technomancer: Welcome to your end. In this universe, dreams become a reality. I am one of your dreams, but now I'll be a nightmare.")
        character4.dialogue.enqueue(" \n Technomancer: Dang it. I've lost. Take your memory and let me fade away!")
        universe4.addCharacter(character4)
        let p = Weapon("plasma rifle", 50,25,45)
        universe4._npc?.addItem(p)
        let character5 : NPC = NPC(500, "Professor Tyrone",100)
        character5.dialogue.enqueue(" \n Professor Tyrone: It's good to see you again. In this universe, accomplishements are scarce. No one here ever succeeds at anything; however, I will be successful at destroying you")
        character5.dialogue.enqueue(" \n Professor Tyrone: I am merely a copy of someone you knew. Take yoour fragment and find out. Farewell")
        universe5.addCharacter(character5)
        let l = Weapon("gold sword", 35,50,60)
        universe5._npc?.addItem(l)
        let character6 : NPC = NPC(600, "Cerebro",1000)
        character6.dialogue.enqueue("\n Cerebro: Welcome simpleton. In this universe, everyone's intellectual power is higher than average. I shall unleash mine upon you.")
        character6.dialogue.enqueue("\n Cerebro: How could this be? I am superior to you in every regard. Take your memory and leave my sight")
        universe6.addCharacter(character6)
        let g = Weapon("gun", 40,30,50)
        g.decorate(decorator: WeaponDecorator("energy",10,15,0))
        universe6._npc?.addItem(g)
        let character7 : NPC = NPC(700, "Grimm",60)
        character7.dialogue.enqueue(" Grimm: Welcome. Just to warn you, you don't want this fragment, it will be nothing but pain for you. But challenge me if you want.")
        character7.dialogue.enqueue("\n GrimmAhhhh. You won, but I warned you. Here's your fragment.")
        universe7.addCharacter(character7)
        let h = Weapon("Scythe", 20,50,50)
        universe7._npc?.addItem(h)
        let character8 : NPC = NPC(0, "John",70)
        character8.dialogue.enqueue("\n John: Welcome home son. Yes I am your father and this is your home universe. I would like to celebrate your return, but there is no time left. Take your memory and fight the Dark One")
        character8.dialogue.enqueue("\n John: Yes and we all love you and will be rooting for you here. Now go on and beat him, Grant")
        universe8.addCharacter(character8)
        let character9 : NPC = NPC(900, "Dark One",80)
        universe9.addCharacter(character9)
        let s = Weapon("sword", 60,70,30)
        s.decorate(decorator: WeaponDecorator("chaos",10,0,0))
        universe9._npc?.addItem(s)
        let characterM : NPC = NPC(0, "Merchant",1000)
        characterM.dialogue.enqueue("\n Welcome to the Market. What can i help you with today? Purchase or Sell?")
        universe12.addCharacter(characterM)
        
        let a1 = Armor("dragon armor",60,50,30)
        let a2 = Armor("steel armor",50,40,30)
        let a3 = Armor("magic armor",80,90,30)
        let a4 = Armor("energy armor",20,20,30)
        let w1 = Weapon("battle axe", 60,70,30)
        let w2 = Weapon("dagger", 50,30,30)
        let w3 = Weapon("machine gun",40,20,50)
        let w4 = Weapon("mchete", 20,70,30)
        universe12._npc?.addItem(a1)
        universe12._npc?.addItem(a2)
        universe12._npc?.addItem(a3)
        universe12._npc?.addItem(a4)
        universe12._npc?.addItem(w1)
        universe12._npc?.addItem(w2)
        universe12._npc?.addItem(w3)
        universe12._npc?.addItem(w4)
        
        //Gives the NPCS memory fragments to hold onto
        universe1._npc?.memory(mem)
        universe2._npc?.memory(mem2)
        universe3._npc?.memory(mem3)
        universe4._npc?.memory(mem4)
        universe5._npc?.memory(mem5)
        universe6._npc?.memory(mem6)
        universe7._npc?.memory(mem7)
        universe8._npc?.memory(mem8)

        
        //Creation of the portals. Each portal except for the Universe and the Market will be unlocked as they have no required memory fragments.
        var portal : Portal = connect(firstU: midway, secondU: universe1, firstLabel: "midway", secondLabel: "Universe1")
        portal = connect(firstU: midway, secondU: universe2, firstLabel: "midway", secondLabel: "Universe2")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe3, firstLabel: "midway", secondLabel: "Universe3")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe4, firstLabel: "midway", secondLabel: "Universe4")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe5, firstLabel: "midway", secondLabel: "Universe5")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe6, firstLabel: "midway", secondLabel: "Universe6")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe7, firstLabel: "midway", secondLabel: "Universe7")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe8, firstLabel: "midway", secondLabel: "Universe8")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe9, firstLabel: "midway", secondLabel: "DarkPalace")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe10, firstLabel: "midway", secondLabel: "NegativeZone")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe11, firstLabel: "midway", secondLabel: "UnknownWorlds")
        portal.lock()
        portal = connect(firstU: midway, secondU: universe12, firstLabel: "midway", secondLabel: "Market")
        
        
        universe5.insertItem(Weapon("plasma rifle", 50,25,45))
        universe3.insertItem(Weapon("plasma shotgun", 50,25,45))
        universe7.insertItem(Armor("kachine metal armor", 40,25,55))
        universe4.insertItem(Armor("gold armor", 30,25,60))
        let w = Weapon("sword", 30,50,40) //This weapon and armor will be the starting items for the player
        midway.insertItem(w)
        let a = Armor("armor", 80,50,40)
        midway.insertItem(a)
        
        return midway
    }
    
    func playerWillEnterRoom(notification: Notification)-> Void{ //Warns the player if an enemy is in the Universe or there's a friendly NPC in there
        let univ : Universe = notification.object as! Universe //Takes the notification and casts it to the Universe
        if (univ._npc != nil) {
            if(univ._npc!.name != "Merchant" && univ._npc!.name != "John"){//The names here are friendly and are not hostiles
            player?.outputMessage("\n Enemy detected. Enemy known as: \(univ._npc!.name) in here", color: NSColor.green) //Tells the player the name of the enemy
            }
            else{
                player?.outputMessage("\n No enemy here. Only a being known as : \(univ._npc!.name) in here", color: NSColor.cyan)//Tells the payer the name of the friendly NPC
            }
        } //This is a way to see whether you have entered a speci
    }

    func start() {
        playing = true
        player?.outputMessage(welcome())
    }
    
    func end() {
        playing = false
        player?.outputMessage(goodbye())
    }
    
    func bossNPC(notification: Notification)-> Void{//Once the player defeats the Dark One NPC, the game will end.
        end()
    }
    
    func welcome() -> String {
        let message = "Welcome to Midway player.\n You are probably wondering why you are here and more importantly you are. I shall explain this one time.\n There exists 12 Universe within the physical plain this of reality. Each universe is vastly different from each other, but some may contain similarities. These unvierse were spawned from the a psuedo universe called the Negative Zone. In this universe, there exist no life or any light. This place is completely shrouded in darkness and is a dumping ground for the negative energy from being from the 12 universe. That is where the Dark One is from. The Dark One is ebing nearly omnipotent being who draws his powers from the Negative Zone. He has come to rule over all universes, but he has issued a challenge to you specically. He wishes to test you for some reason. But you can't just go see him.\nAs his herald, I will inform you of this challenge. I pointed out earlier that you dont seem to know who you are; the Dark One took all of your memories and fragmented into 12 pieces. He has placed each piece in a universe for you to find, but you will encounter challenges in each universe. You may pickup weapons along the way to defeat your enemies and reclaim your memories. Once you have reclaimed all 12 memory fragments, you will be able to challenge the Dark One is his palace. I will alert you of certain accomplishments along your journey. I have given you a weapon, armor, and 50 coins to start. Enter pickup to obtain your items .Good luck"
        return "\(message)\n\n\(player!.currentUniverse.description())"
        
    }
    
    func goodbye() -> String {
        return "\nThank you for playing, Goodbye.\n"
    }
    
    func execute(_ commandString : String) -> Bool {
        var finished : Bool = false
        if playing {
            player?.commandMessage("\n>\(commandString)")
            let command : Command? = parser.parseCommand(commandString)
            if command != nil {
                finished = (command?.execute(player!))!
            } else {
                player?.errorMessage("\nI don't understand...")
            }
        }
        return finished
    }
}
