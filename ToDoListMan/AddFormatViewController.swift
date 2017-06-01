//
//  AddFormatViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 31..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class AddFormatViewController: UIViewController {

    
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editDetail: UITextField!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    
    var formatTitle = ""
    var formatDetail = ""
    var formatStartTime = ""
    var formatEndTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnAccClicked(_ sender: Any) {
        self.formatTitle = self.editTitle.text!
        self.formatDetail = self.editDetail.text!
        
        startTime.datePickerMode = UIDatePickerMode.time
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        var startDate = dateFormatter.string(from: startTime.date)
        var endDate = dateFormatter.string(from: endTime.date)
        self.formatStartTime = startDate
        self.formatEndTime = endDate
        print(startDate,"  ",endDate)
        
    }
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
