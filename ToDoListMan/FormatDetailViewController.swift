//
//  FormatDetailViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 27..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class FormatDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var plans : [format] = []
    var curFormatName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        var database = FIRDatabase.database()
        var ref = database.reference().child("format").child((FIRAuth.auth()?.currentUser?.uid)!)
            .child(curFormatName)
        ref.observe(FIRDataEventType.childAdded, with: { (dataSnapShot) in
                let a = (dataSnapShot as! FIRDataSnapshot).value as! NSDictionary
                
                var item = format(planName : a["planName"] as! String, id: a["id"] as! Int, detail : a["detail"] as! String, startTime : a["startTime"] as! String, endTime : a["endTime"] as! String)
                self.plans.append(item)
            
            
            print("this is ",self.plans.count,"  ",self.plans[self.plans.count-1].planName as! String)
            self.tableView.insertRows(at: [IndexPath(row: self.plans.count-1,section: 0)], with: UITableViewRowAnimation.automatic)
        })
        
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
    
}

    
    extension FormatDetailViewController:UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.plans.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "FormatDetailTableViewCell", for: indexPath) as! FormatDetailTableViewCell
            print("this is ",self.plans.count,"  ",self.plans[indexPath.row].planName as! String)
            
            cell.txtPlanName.text = self.plans[indexPath.row].planName
            cell.txtDetail.text = self.plans[indexPath.row].detail
            cell.txtTime.text = self.plans[indexPath.row].startTime
            print("this is", self.plans[indexPath.row].startTime)
            return cell
        }
        
    }
    
    extension FormatDetailViewController:UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //CODE TO BE RUN ON CELL TOUCH
            
            
        }
}
