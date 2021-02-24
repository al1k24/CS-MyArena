//
//  Box.swift
//  CS-MyArena
//
//  Created by Алик on 17.02.2021.
//

import Foundation

final class Box<T> {
    
    typealias Listener = (T) -> ()
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
