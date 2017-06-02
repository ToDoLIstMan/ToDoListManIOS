//
//  PlanViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 26..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sections = ["일 추가"]
    var aa = ["그룹선택 ","포맷선택","당번선택", "날짜선택"]
    var aaa :[String] = []
    
    var chooseName :[String] = []
    var chooseUid : [String] = []
    var curGroup = ""
    var curGroupId = -1
    
    @IBOutlet weak var txtFormat: UILabel!
    @IBOutlet weak var txtGroup: UILabel!
    @IBOutlet weak var txtPeople: UILabel!
    @IBOutlet weak var txtDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print(tableView.numberOfSections)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnFormatClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segCurFormatPick", sender: self)
    }
    
    
    @IBAction func btnGroupClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segCurGroupPick", sender: self)
    }
    
    @IBAction func btnPeopleClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segThing", sender: self)
    }
    
    @IBAction func btnTimeClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "segCurDatePick", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segThing" {
            let send = segue.destination as! AddThingViewController
            send.curGroup = self.curGroup
            send.curGrpId = self.curGroupId
           
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToWorkAdded(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddPlanViewController {
        }
    }


    @IBAction func sendClicked(_ sender: Any) {
        
        
    }
    
    @IBAction func btnWorkAddClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segWork", sender: self)
    }
    
    @IBAction func unwindToCurFormatAdd(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? CurFormatPickViewController {
            print(sourceViewController.pickFormat)
            self.txtFormat.text = sourceViewController.pickFormat
        }
    }
    @IBAction func unwindToCurGroupAdd(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? CurGroupPickViewController {
            self.curGroupId = sourceViewController.pickGrpId
            self.curGroup = sourceViewController.pickGroup
            self.txtGroup.text = sourceViewController.pickGroup
        }
    }
    @IBAction func unwindToCurDateAdd(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? CurDatePickViewController {
            txtDate.text = sourceViewController.date
        }
    }
    @IBAction func unwindToCurThingAdd(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddThingViewController {
            
            txtPeople.text = String(sourceViewController.chooseName.joined(separator: ", "))
            self.chooseName = sourceViewController.chooseName
            self.chooseUid = sourceViewController.chooseUid
        }
    }
    @IBAction func unwindToWorkAdd(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddPlanViewController {
        }
    }
}

extension PlanViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return self.sections[section]
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aaa.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTableAddViewCell", for: indexPath) as! PlanTableAddViewCell
            
            cell.txtTest.text = aaa[indexPath.row]
            return cell
    }
    
}

extension PlanViewController:UITableViewDelegate{
    
}


