//
//  FormatAddViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 27..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class FormatAddViewController: UIViewController {
    var curTitle = ""
    var curDetail = ""
    var curStartTime = ""
    var curEndTime = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    var plans : [format] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.plans.count)
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
    @IBAction func btnAddClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "segAdd", sender: self)
        
    }
    @IBAction func btnSaveClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "포맷명을 입력하세요.", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "저장", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            var database = FIRDatabase.database()
            var ref = database.reference()
            var myref = ref.child("format").child((FIRAuth.auth()?.currentUser?.uid)!).child(firstTextField.text!)
            
            
            for i in 0..<self.plans.count {
                 myref.child(String(i)).setValue(["detail" : self.plans[i].detail,
                                               "endTime" : self.plans[i].endTime ,
                                               "id" : self.plans[i].id ,
                                               "startTime" : self.plans[i].startTime ,
                                               "planName" : self.plans[i].planName])
            
            }
            
            
            
            
            
            let tabBarController = self.tabBarController
            // pop to root vc (green one)
            _ = self.navigationController?.popToRootViewController(animated: false)
            
            // switch to 2nd tab (red vc)
            tabBarController?.selectedIndex = 3
            
        })
        
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "포맷명을 입력하세요."
        }
        
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func unwindToFormatAdd(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddFormatViewController {
            
            self.curTitle = sourceViewController.formatTitle
            self.curDetail = sourceViewController.formatDetail
            self.curStartTime = sourceViewController.formatStartTime
            self.curEndTime = sourceViewController.formatEndTime
            
            var item = format(planName : curTitle, id: self.plans.count, detail : curDetail, startTime : curStartTime, endTime : curEndTime)
            
            self.plans.append(item)
            
             self.tableView.insertRows(at: [IndexPath(row: self.plans.count-1, section: 0)], with: .automatic)
            print(self.plans.count)
            self.tableView.reloadData()
            
           // self.tableView.insertRows(at: [IndexPath(row: self.plans.count-1, section: 0)], with: .automatic)
          //  tableView.endUpdates()
        }
    }
}

extension FormatAddViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("hi!!",section)
        return self.plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FormatAddTableViewCell", for: indexPath) as! FormatAddTableViewCell
        cell.txtPlanName.text = plans[indexPath.row].planName
        cell.txtPlanDetail.text = plans[indexPath.row].detail
        cell.txtPlanTime.text = plans[indexPath.row].startTime
        return cell
    }
    
}

extension FormatAddViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        
        
    }
}
