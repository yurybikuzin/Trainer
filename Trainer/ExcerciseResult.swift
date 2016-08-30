//
//  ExcerciseResult.swift
//  Trainer
//
//  Created by Юрий Бикузин on 30.08.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import Foundation

class ExcerciseResult {
    let labelText: String
    let answerText: String
    let isValidAnswer: Bool
    let timing: TimeInterval
    init (labelText: String, answerText: String, isValidAnswer: Bool, timing: TimeInterval) {
        self.labelText = labelText
        self.answerText = answerText
        self.isValidAnswer = isValidAnswer
        self.timing = timing
    }
}

class ExcerciseResultPack {
    let startDate: Date
    let author: String
    let title: String
    var excerciseResults = [ExcerciseResult]()
    var errorCount: Int {
        var errorCount = 0
        for excerciseResult in excerciseResults {
            if !excerciseResult.isValidAnswer {
                errorCount += 1
            }
        }
        return errorCount
    }
    var isComplete = false
    var timing: TimeInterval = 0
    init (startDate: Date, author: String, title: String) {
        self.startDate = startDate
        self.author = author
        self.title = title
    }
}
