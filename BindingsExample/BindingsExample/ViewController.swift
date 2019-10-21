//
//  ViewController.swift
//  BindingsExample
//
//  Created by Karol Harasim on 26/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit


struct User {
    var name: Observable<String>
}

class Observable<ObservedType> {
    private var _value: ObservedType?
    var valueChanged: ((ObservedType?) -> ())?
    
    public var value: ObservedType? {
        get {
            return _value
        }
        
        set {
            _value = newValue
            valueChanged?(_value)
        }
    }
    
    init(_ value: ObservedType) {
        _value = value
    }
    
    func bindingChanged(to newValue: ObservedType) {
        _value = newValue
        print("Value is now \(newValue)")
    }
}

class BoundTextField: UITextField {
    var changedClosure: (() -> ())?
    @objc func valueChanged() {
       changedClosure?()
    }
    
    func bind(to observable: Observable<String>) {
        addTarget(self, action: #selector(BoundTextField.valueChanged), for: .editingChanged)
        changedClosure = { [weak self] in
            observable.bindingChanged(to: self?.text ?? " ")
        }
        observable.valueChanged = { [weak self] newValue in
            self?.text = newValue
        }
    }
}




class ViewController: UIViewController {
    @IBOutlet var username: BoundTextField!
    
    var user = User(name: Observable("Karol Harasim"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.bind(to: user.name)
    }


}

