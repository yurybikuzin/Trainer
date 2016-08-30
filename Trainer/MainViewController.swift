//
//  MainViewController.swift
//  Trainer
//
//  Created by Yury Bikuzin on 19.08.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import UIKit

class ChoiceGroup {
    let title: String
    let excerciseGenerators: [ExcerciseGenerator]
    init(title: String, excerciseGenerators: [ExcerciseGenerator]) {
        self.title = title
        self.excerciseGenerators = excerciseGenerators
    }
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet var choiceView: UIView!
    @IBOutlet var startView: UIView!
    @IBOutlet var excerciseView: UIView!
    @IBOutlet var resultView: UIView!
    @IBOutlet weak var pageContainerView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    enum Page {
        case none
        case choice
        case start
        case excercise
        case result
    }
    
    var choices: [ChoiceGroup] = []
    var selectedChoice: ExcerciseGenerator?
    
    var pageContainerConstraints: [NSLayoutConstraint] = []
    
    var _currentPage: Page = .none
    
    var currentPage: Page {
        get { return _currentPage }
        set {
            if _currentPage != newValue {
                NSLayoutConstraint.deactivate(pageContainerConstraints)
                pageContainerConstraints.removeAll()
                if let pageView = self.pageView {
                    pageView.removeFromSuperview()
                }
                _currentPage = newValue
                if let pageView = self.pageView {
                    pageView.translatesAutoresizingMaskIntoConstraints = false
                    pageContainerView.addSubview(pageView)
                    pageContainerConstraints.append(NSLayoutConstraint.init(item: pageView, attribute: .leading, relatedBy: .equal, toItem: pageContainerView, attribute: .leading, multiplier: 1, constant: 0))
                    pageContainerConstraints.append(NSLayoutConstraint.init(item: pageView, attribute: .trailing, relatedBy: .equal, toItem: pageContainerView, attribute: .trailing, multiplier: 1, constant: 0))
                    pageContainerConstraints.append(NSLayoutConstraint.init(item: pageView, attribute: .top, relatedBy: .equal, toItem: pageContainerView, attribute: .top, multiplier: 1, constant: 0))
                    pageContainerConstraints.append(NSLayoutConstraint.init(item: pageView, attribute: .bottom, relatedBy: .equal, toItem: pageContainerView, attribute: .bottom, multiplier: 1, constant: 0))
                    NSLayoutConstraint.activate(pageContainerConstraints)
                }
                switch _currentPage {
                case .none:
                    break
                case .choice:
                    stopExcerciseElapsedTimer()
                case .start:
                    selectedChoiceLabel.text = selectedChoice!.title
                case .excercise:
                    setExcercise(excercises.popLast()!)
                    startExcerciseElapsedTimer()
                    excerciseAnswerTextField.becomeFirstResponder()
                case .result:
                    stopExcerciseElapsedTimer()
                    resultLabel.text = excerciseElapsedTimeText
                }
            }
        }
    }
    @IBOutlet weak var selectedChoiceLabel: UILabel!
    
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    var _excerciseElapsedTime: TimeInterval = 0
    
    var excerciseElapsedTime: TimeInterval {
        get {
            return _excerciseElapsedTime
        }
        set {
            _excerciseElapsedTime = newValue
            elapsedTimeLabel.text = excerciseElapsedTimeText
        }
    }
    var excerciseElapsedTimeText: String {
        let seconds = Int(_excerciseElapsedTime.truncatingRemainder(dividingBy: 60))
        let minutes = Int((_excerciseElapsedTime / 60).truncatingRemainder(dividingBy: 60))
        let hours = Int(_excerciseElapsedTime / 3600)
        let result = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        return result
    }
    var excerciseElapsedTimer: Timer? = nil
    let excerciseElapsedTimerTimeInterval: TimeInterval = 1
    func startExcerciseElapsedTimer() {
        excerciseElapsedTime = 0
        excerciseElapsedTimer = Timer.scheduledTimer(timeInterval: excerciseElapsedTimerTimeInterval, target: self, selector: #selector(excerciseElapsedTimerFired), userInfo: nil, repeats: true)
    }
    
    @objc func excerciseElapsedTimerFired() {
        excerciseElapsedTime += excerciseElapsedTimerTimeInterval
    }
    
    func registerKeyboardEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unregisterKeyboardEvent() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBOutlet weak var pageContainerViewHeightConstraint: NSLayoutConstraint!
    @objc func keyboardWillHide() {
        pageContainerViewHeightConstraint.isActive = false
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                pageContainerViewHeightConstraint.constant = view.frame.height - keyboardFrameEnd.height
                pageContainerViewHeightConstraint.isActive = true
            }
        }
    }
    
    func stopExcerciseElapsedTimer() {
        excerciseElapsedTimer?.invalidate()
        excerciseElapsedTimer = nil
    }
    
    @IBAction func toStartButtonPressed() {
        currentPage = .choice
    }
    
    @IBAction func startButtonPressed() {
        excercises = selectedChoice!.getExcercises()
        initialExcerciseCount = excercises.count
        if initialExcerciseCount > 0 {
            currentPage = .excercise
        }
    }
    
    var pageView: UIView? {
        var result: UIView? = nil
        switch _currentPage {
        case .none:
        break
        case .choice:
            result = choiceView
        case .start:
            result = startView
        case .excercise:
            result = excerciseView
        case .result:
            result = resultView
        }
        return result
    }
    
    var excercises: [Excercise] = []
    var initialExcerciseCount: Int = 0
    
    @IBOutlet weak var pageContainerViewTopConstraint: NSLayoutConstraint!
    
    // http://stackoverflow.com/a/16598350
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return min(statusBarSize.width, statusBarSize.height)
    }
    
    override func viewDidLoad() {        
        super.viewDidLoad()

        pageContainerViewTopConstraint.constant = statusBarHeight()
        
        setupChoices()
        
        currentPage = .choice
        
        registerKeyboardEvent()
        
        setupKeyboardToolbar()
    }
    
    func setupChoices() {
        choices = []
        do {
            var excerciseGenerators = [ExcerciseGenerator]()
            for i in 0 ... 10 {
                excerciseGenerators.append(MultiplyExcerciseGenerator.init(by: i))
            }
            choices.append(ChoiceGroup.init(title: "Умножение", excerciseGenerators: excerciseGenerators))
        }
        do {
            var excerciseGenerators = [ExcerciseGenerator]()
            for i in 0 ... 10 {
                excerciseGenerators.append(DivisionExcerciseGenerator.init(by: i))
            }
            choices.append(ChoiceGroup.init(title: "Деление", excerciseGenerators: excerciseGenerators))
        }
    }

    deinit {
        unregisterKeyboardEvent()
    }
    
    var keyboardDoneButton: UIBarButtonItem? = nil
    func setupKeyboardToolbar() {
        let resetButton = UIBarButtonItem.init(title: "Прекратить", style: UIBarButtonItemStyle.plain, target: self, action: #selector(resetButtonPressed(sender:)))
        let flexButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        keyboardDoneButton = UIBarButtonItem.init(title: "Готово", style: UIBarButtonItemStyle.plain, target: self, action: #selector(keyboardDoneButtonPressed(sender:)))
        let keyboardToolbar = UIToolbar.init()
        keyboardToolbar.items = [resetButton, flexButton, keyboardDoneButton!]
        excerciseAnswerTextField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
    }
    
    @objc func resetButtonPressed(sender: UIBarButtonItem) {
        currentPage = .choice
    }
    
    @objc func keyboardDoneButtonPressed(sender: UIBarButtonItem) {
        checkAnswer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var excerciseLabel: UILabel!
    @IBOutlet weak var excerciseAnswerTextField: UITextField!
    
    var currentExcercise: Excercise?
    
    @IBOutlet weak var progressView: UIProgressView!
    func setExcercise(_ excercise: Excercise) {
        keyboardDoneButton?.isEnabled = false
        currentExcercise = excercise
        excerciseLabel.text = excercise.labelText
        excerciseAnswerTextField.text = ""
        if initialExcerciseCount > 0 {
            progressView.progress = Float(initialExcerciseCount - excercises.count - 1) / Float(initialExcerciseCount)
        }
    }
    
    @IBAction func excerciseAnswerTextEditChanged(_ sender: UITextField) {
        keyboardDoneButton?.isEnabled = (sender.text?.characters.count)! > 0
    }
    
    func checkAnswer() {
        keyboardDoneButton?.isEnabled = false
        if let answer = Int(excerciseAnswerTextField.text!) {
            let isValid = currentExcercise!.isValid(answer: answer)
            if !isValid {
                excercises.insert(currentExcercise!, at: 0)
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.excerciseAnswerTextField.backgroundColor = isValid ? UIColor.green : UIColor.red
                }, completion: { (Bool) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.excerciseAnswerTextField.backgroundColor = UIColor.clear
                        }, completion: { (Bool) in
                            if let excercise = self.excercises.popLast() {
                                self.setExcercise(excercise)
                            } else {
                                self.currentPage = .result
                            }
                    })
            })
        }
    }
    
    @IBAction func backToChoiceButtonPressed(_ sender: AnyObject) {
        currentPage = .choice
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkAnswer()
        return true
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return choices[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices[section].excerciseGenerators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil  {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell!.textLabel?.text = choices[indexPath.section].excerciseGenerators[indexPath.row].title
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedChoice = choices[indexPath.section].excerciseGenerators[indexPath.row]
        currentPage = .start
    }
    
}
