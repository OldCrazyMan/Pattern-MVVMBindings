//
//  Dynamic.swift
//  MVVMBindings
//
//  Created by Tim Akhm on 03.02.2023.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> ()
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
        
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
