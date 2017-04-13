//
//  ViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 12..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiTxtId: UITextField!
    @IBOutlet weak var uiTxtPwd: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uiTxtId.placeholder = "ID"
        uiTxtPwd.placeholder = "비밀번호"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btSignInClick(_ sender: Any) {
    }
}

