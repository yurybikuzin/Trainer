//
//  Excercise.swift
//  Trainer
//
//  Created by Yury Bikuzin on 19.08.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import Foundation

protocol ExcerciseItem {
    var labelText: String { get }
    func isValid(answer: Int) -> Bool
}

protocol Excercise {
    func reset
    func getNextItem: ExcerciseItem?
}

class MultiplyExercise: Excercise {
    init() {
        
    }
}
