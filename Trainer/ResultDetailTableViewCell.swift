//
//  ResultDetailTableViewCell.swift
//  Trainer
//
//  Created by Yury Bikuzin on 04.09.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import UIKit

class ResultDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var answerTextLabel: UILabel!
    @IBOutlet weak var excerciseTextLabel: UILabel!
    @IBOutlet weak var timingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(excerciseResult: ExcerciseResult) {
        timingLabel.text = excerciseResult.timing.timeTextWithMsec
        excerciseTextLabel.text = excerciseResult.labelText
        answerTextLabel.setAnswer(excerciseResult.answerText, isValid: excerciseResult.isValidAnswer)
    }
}

extension UILabel {
    func setAnswer(_ answerText: String, isValid: Bool) {
        text = answerText
        textColor = isValid ? UIColor.init(red: 0, green: 128/255, blue: 0, alpha: 1) : UIColor.red
    }
}
