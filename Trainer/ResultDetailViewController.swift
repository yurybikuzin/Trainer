//
//  ResultDetailViewController.swift
//  Trainer
//
//  Created by Yury Bikuzin on 03.09.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import UIKit

class ResultDetailViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var errorCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNibOfClass(ResultDetailTableViewCell.self)
        navigationItem.title = "Подробности теста"
        titleLabel.text = excerciseResultPack.title
        errorCountLabel.setErrorCount(excerciseResultPack.errorCount)
        elapsedTimeLabel.text = excerciseResultPack.timing.timeText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    let excerciseResultPack: ExcerciseResultPack
    init(excerciseResultPack: ExcerciseResultPack) {
        self.excerciseResultPack = excerciseResultPack
        super.init(nibName: "ResultDetailViewController", bundle: nil)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excerciseResultPack.excerciseResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellOfClass(ResultDetailTableViewCell.self, for: indexPath)
        cell.set(excerciseResult: excerciseResultPack.excerciseResults[indexPath.row])
        return cell
    }

}

extension UITableView {
    func registerNibOfClass(_ classToRegister: AnyClass) {
        let nibName = NSStringFromClass(classToRegister).characters.split(separator: ".").map(String.init).last!
        register(UINib.init(nibName: nibName, bundle: Bundle.main), forCellReuseIdentifier: NSStringFromClass(classToRegister))
    }
    func dequeueReusableCellOfClass<T>(_ classOfCell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: NSStringFromClass(T.self as! (AnyClass)), for: indexPath) as! T
    }
}
