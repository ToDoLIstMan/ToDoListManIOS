//
//  WorkDetailViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 26..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class WorkDetailViewController: UIViewController {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var txtPeople: UITextView!
    @IBOutlet weak var txtDetail: UITextView!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var btnPostpone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "hello"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFinishclicked(_ sender: Any) {
    }

    @IBOutlet weak var btnPostponeClicked: UIButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
