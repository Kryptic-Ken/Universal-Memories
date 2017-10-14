//
//  Armor.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/30/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class Armor : Item{
    private var _name: String
    private var _hitPoints: Int
    private var _value: Int
    private var _weight: Int
    private var _defense: Int
    private var _decorator : Item?
    var itemID: Int
    
    var name : String{
        get{
            return ((_decorator != nil) ? _decorator!.name + " " : "") + _name //If there is a decorator in the this Item, its name will be added to the name of this Item

        }
        
        set{
            _name = newValue
        }
    }
    
    var value : Int{
        get{
            return _value + ((_decorator != nil) ? _decorator!.value : 0) // if I have a decorator, add it's value; if not, add 0
        }
        set{
            _value = newValue
        }
    }
    
    var hitPoints : Int{
        get{
            return _hitPoints + ((_decorator != nil) ? _decorator!.hitPoints : 0) // if I have a decorator, add it's value; if not, add 0
        }
        set{
            _hitPoints = hitPoints
        }
    }
    var weight : Int{
        get{
            return _weight + ((_decorator != nil) ? _decorator!.weight : 0) // if I have a decorator, add it's value; if not, add 0
        }
        set{
            _weight = weight
        }
    }
    var defense : Int{
        get{
            return _defense + ((_decorator != nil) ? _decorator!.defense : 0) // if I have a decorator, add it's value; if not, add 0
        }
        set{
            _defense = defense
        }
    }
    convenience init(){
        self.init("shield", 50, 40, 50)
    }
    init(_ nameN :String, _ defense : Int,_ valueN: Int,_ weightN: Int ){
        _name = nameN
        _hitPoints = 0    // Since this item is armor, its hitPoints will always be 0
        _value = valueN
        _weight = weightN
        _defense = defense
        itemID = 3
    }
    
    func decorate(decorator : Item){
        if (_decorator == nil){
            _decorator = decorator
        }
            
        else{
            _decorator?.decorate(decorator: decorator)
        }
    }
    func description()->String{
        return name
    }
    
    func armorDec(_ dec : Int){//Function will decrease the armor's defense pointss during combat
        _defense -= dec
    }
}
