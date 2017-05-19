//
//  GroupPickerViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 27..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class GroupPickerViewController: UIViewController,UIPickerViewDelegate {

    @IBOutlet weak var groupPicker: UIPickerView!
    
    var myGroup : [String] = []
    var myGroupId : [Int] = []
    var pickGroup = ""
    var pickGrpId = -1
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.groupPicker.delegate = self;
        
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
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
 
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myGroup.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        self.pickGrpId = self.myGroupId[row]
        self.pickGroup = self.myGroup[row]
        return myGroup[row]
    }
    
    
    @IBAction func btnAccClicked(_ sender: Any) {
        print(self.pickGroup)
    }

    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
