//
//  Excercise.swift
//  Trainer
//
//  Created by Yury Bikuzin on 19.08.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import Foundation

protocol Excercise {
    var labelText: String { get }
    func isValid(answer: Int) -> Bool
}

protocol ExcerciseGenerator {
    var title: String { get }
    func getExcercises() -> [Excercise]
}

class DivisionExcercise: Excercise {
    let left, right: Int
    init(left: Int, right: Int) {
        self.left = left
        self.right = right
    }
    
    // MARK: == Excercise
    
    var labelText: String {
        return "\(left * right) : \(left) = "
    }
    func isValid(answer: Int) -> Bool {
        return answer == right
    }
}

class MultiplyExcercise: Excercise {
    let left, right: Int
    init(left: Int, right: Int) {
        self.left = left
        self.right = right
    }
    
    // MARK: == Excercise
    
    var labelText: String {
        return "\(left) * \(right) = "
    }
    func isValid(answer: Int) -> Bool {
        return answer == left * right
    }
}

class SubtractionExcercise: Excercise {
    let left, right: Int
    init(left: Int, right: Int) {
        self.left = left
        self.right = right
    }
    
    // MARK: == Excercise
    
    var labelText: String {
        return "\(left + right) - \(left) = "
    }
    func isValid(answer: Int) -> Bool {
        return answer == right
    }
}

class AdditionExercise: Excercise {
    let left, right: Int
    init(left: Int, right: Int) {
        self.left = left
        self.right = right
    }
    
    // MARK: == Excercise
    
    var labelText: String {
        return "\(left) + \(right) = "
    }
    func isValid(answer: Int) -> Bool {
        return answer == left + right
    }
}

class AdditionTill20ExcerciseGenerator: ExcerciseGenerator {
    let title: String = "Сложение до 20"
    
    // MARK: == ExcerciseGenerator
    func getExcercises() -> [Excercise] {
        var excercises: [Excercise] = []
        
        for i in (10 ... 20) {
            let min = 2
            let left = Int(arc4random_uniform(UInt32(i - min * 2)) + UInt32(min))
            let right = i - left
            excercises.append(AdditionExercise.init(left: left, right: right))
        }
        excercises.shuffle()
        
        return excercises
    }
}

class SubtractionTill20ExcerciseGenerator: ExcerciseGenerator {
    let title: String = "Вычитание до 20"
    
    // MARK: == ExcerciseGenerator
    func getExcercises() -> [Excercise] {
        var excercises: [Excercise] = []
        
        for i in (10 ... 20) {
            let min = 2
            let left = Int(arc4random_uniform(UInt32(i - min * 2)) + UInt32(min))
            let right = i - left
            excercises.append(SubtractionExcercise.init(left: left, right: right))
        }
        excercises.shuffle()
        
        return excercises
    }
}

class AdditionExcerciseGenerator: ExcerciseGenerator {
    let title: String
    let minSum: Int
    let maxSum: Int
    let minParam: Int
    let count: Int
    
    init(title: String, minSum: Int, maxSum: Int, minParam: Int, count: Int) {
        self.title = title
        self.minSum = minSum
        self.maxSum = maxSum
        self.minParam = minParam
        self.count = count
    }
    // MARK: == ExcerciseGenerator
    func getExcercises() -> [Excercise] {
        var excercises: [Excercise] = []
        
        for _ in (0 ..< count) {
            let sum = Int(arc4random_uniform(UInt32(maxSum - minSum)) + UInt32(minSum))
            let left = Int(arc4random_uniform(UInt32(sum - minParam * 2)) + UInt32(minParam))
            let right = sum - left
            excercises.append(AdditionExercise.init(left: left, right: right))
        }
        excercises.shuffle()
        
        return excercises
    }
}

class SubtractionExcerciseGenerator: ExcerciseGenerator {
    let title: String
    let minSum: Int
    let maxSum: Int
    let minParam: Int
    let count: Int
    
    init(title: String, minSum: Int, maxSum: Int, minParam: Int, count: Int) {
        self.title = title
        self.minSum = minSum
        self.maxSum = maxSum
        self.minParam = minParam
        self.count = count
    }
    // MARK: == ExcerciseGenerator
    func getExcercises() -> [Excercise] {
        var excercises: [Excercise] = []
        
        for _ in (0 ..< count) {
            let sum = Int(arc4random_uniform(UInt32(maxSum - minSum)) + UInt32(minSum))
            let left = Int(arc4random_uniform(UInt32(sum - minParam * 2)) + UInt32(minParam))
            let right = sum - left
            excercises.append(SubtractionExcercise.init(left: left, right: right))
        }
        excercises.shuffle()
        
        return excercises
    }
}

class MultiplyExcerciseGenerator: ExcerciseGenerator {
    let title: String
    let by: Int
    init(by: Int = 0) {
        self.by = by
        if by == 0 {
            title = "Вся таблица умножения"
        } else {
            title = "Умножение на \(by)"
        }
    }
    
    // MARK: == ExcerciseGenerator
    
    func getExcercises() -> [Excercise] {
        var excercises: [Excercise] = []
        
        func helper(i: Int) {
            for j in (1 ... 10) {
                excercises.append(MultiplyExcercise.init(left: i, right: j))
            }
        }
        
        if by == 0 {
            for i in (1 ... 10) {
                helper(i: i)
            }
        } else {
            helper(i: by)
        }
        
        excercises.shuffle()
        
        return excercises
    }
}

class DivisionExcerciseGenerator: ExcerciseGenerator {
    let title: String
    let by: Int
    init(by: Int = 0) {
        self.by = by
        if by == 0 {
            title = "Вся таблица деления"
        } else {
            title = "Деление на \(by)"
        }
    }
    
    // MARK: == ExcerciseGenerator
    
    func getExcercises() -> [Excercise] {
        var excercises: [Excercise] = []
        
        func helper(i: Int) {
            for j in (1 ... 10) {
                excercises.append(DivisionExcercise.init(left: i, right: j))
            }
        }
        
        if by == 0 {
            for i in (1 ... 10) {
                helper(i: i)
            }
        } else {
            helper(i: by)
        }
        
        excercises.shuffle()
        
        return excercises
    }
}

// http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> [Generator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}

extension MutableCollection where Index == Int, IndexDistance == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

