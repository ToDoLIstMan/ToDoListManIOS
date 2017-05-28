//
//  TimePickerViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 26..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var btnOk: UIButton!
    
    var date : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 5
        popView.layer.masksToBounds = true

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

    

    @IBAction func btnActClicked(_ sender: Any) {
        datePicker.datePickerMode = UIDatePickerMode.date
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var selectedDate = dateFormatter.string(from: datePicker.date)
        self.date = selectedDate
        print(selectedDate)
        
      //  performSegue(withIdentifier: "unWindDate", sender: self)
        
    }
    @IBAction func btnCancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindDate" {
            let sendtimer=segue.destination as! MainViewController
            sendtimer.date = self.date

        }
    }
}
