//
//  Parser.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class Parser {
    var commands : CommandWords
    
    init(newCommands : CommandWords) {
        commands = newCommands
    }
    
    func parseCommand(_ commandString : String) -> Command? {
        
        var command : Command? = commands.get("")
        let words = commandString.components(separatedBy: " ")
        //print(words.count)
        if words.count > 0 {
            command = commands.get(words[0])
            if command != nil {
                if words.count > 1 {
                    if(words.count == 2){
                        command?.secondWord = words[1]
                    }
                    else{ //Condition for mare than 3
                        var word = words[1] //stores the second word
                        for i in 2..<words.count{ //For loops appends the remaining words together as one string separated by spaces
                            word += " "
                            word += words[i]
                        }
                        command?.secondWord = word //This newly joined word becomes the second word
                    }
                }
                else {
                    command?.secondWord = nil
                }
            }
            
            }
        return command
        }
    
    
    func description() -> String {
        return commands.description()
    }
}
