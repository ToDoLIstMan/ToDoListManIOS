//
//  AddPlanViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 5. 31..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class AddPlanViewController: UIViewController {

    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editDetail: UITextField!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    var curGrpId = -1
    
    @IBOutlet weak var list: UITableView!
    var curGroup : String = ""
    var txtTitle : String = ""
    var txtdetail : String = ""
    var txtStarTime : String = ""
    var txtEndTime : String = ""
    
    
    var names : [userChoose] = []
    
    var chooseName : [String] = []
    var chooseUid : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.delegate = self
        list.dataSource = self
        // Do any additional setup after loading the view.
        var database = FIRDatabase.database()
        var ref = database.reference()
        ref.child("group").child(String(curGrpId)).observe(FIRDataEventType.value, with: { (snapShot) in
            let a = snapShot.value as! NSDictionary
            var curmember : [String] = a["memberName"] as! [String]
            var curmemberuid : [String] = a["memberUid"] as! [String]
            print(curmember.count)
            for i in 0...(curmember.count-1) {
                self.names.append(userChoose(name: curmember[i],uid: curmemberuid[i],isCheck: false))
            }
            print(snapShot)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnAccClicked(_ sender: Any) {
        
        print(editTitle.text!)
        txtTitle = editTitle.text!
        txtdetail = editDetail.text!
        
        startTime.datePickerMode = UIDatePickerMode.time
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        var startDate = dateFormatter.string(from: startTime.date)
        var endDate = dateFormatter.string(from: endTime.date)
        self.txtStarTime = startDate
        self.txtEndTime = endDate
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AddPlanViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = self.list.dequeueReusableCell(withIdentifier: "AddCurMemberTableViewCell", for: indexPath) as! AddCurMemberTableViewCell
        cell.txtName.text = names[indexPath.row].name
        
        cell.tapAction = { [weak self] (cell) in
            var ischanged = false
            if  !(self?.names[tableView.indexPath(for: cell)!.row].isCheck)! {
                self?.names[tableView.indexPath(for: cell)!.row].changeCheck  = true
                self?.chooseName.append((self?.names[tableView.indexPath(for: cell)!.row].name)!)
                self?.chooseUid.append((self?.names[tableView.indexPath(for: cell)!.row].uid)!)
                
                ischanged = true
            } else {
                if !ischanged {
                    self?.names[tableView.indexPath(for: cell)!.row].changeCheck  = false
                    if let index = self?.chooseName.index(of: (self?.names[tableView.indexPath(for: cell)!.row].name)!) {
                        self?.chooseName.remove(at: index)
                        self?.chooseUid.remove(at: index)
                    }
                }
            }
        }
        
        return cell }
    
}

extension AddPlanViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        print(indexPath.row)
        
    }
    
}


