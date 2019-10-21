//
//  ViewController.swift
//  Milestone: Projects 7-9
//
//  Created by Karol Harasim on 17/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentAnswer: UITextField!
    var letterButtons = [UIButton]()
    var hangmanView : HangManView!
    var allWords = [String]()
    var userLetters = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    
    }


}

