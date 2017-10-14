//
//  LinkedQueue.swift
//  StarterGame
//
//  Created by Kendrick Gholston on 4/30/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

private class Node<T> {
    let data: T
    var next: Node?
    
    init(data: T) {
        self.data = data
    }
}

class LinkedQueue<T> {
    
    private var head: Node<T>?
    private var tail: Node<T>?
    var size: Int = 0
    
    func enqueue(_ element: T) {
        let node = Node(data: element)
        if let lastN = tail {
            lastN.next = node
        } else {
            head = node
        }
        tail = node
        size += 1
        
    }
    
    func dequeue() -> T? {
        if let firstN = head {
            head = firstN.next
            if head == nil {
                tail = nil
            }
            size-=1
            return firstN.data
        } else {
            return nil
        }
    }
    func peek()->T{
        return head!.data
    }
    func isEmpty()-> Bool{
        if(size == 0){
            return true
        }
        else{
            return false
        }
    }
}
