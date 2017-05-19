//
//  FormatViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 27..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class FormatViewController: UIViewController {
    var names:[format] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddFormat: UIBarButtonItem!
    var ref: FIRDatabaseReference!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self as? UITableViewDelegate
        // Do any additional setup after loading the view.
        
        self.ref = FIRDatabase.database().reference()
        
        self.ref.child("format").observe(FIRDataEventType.value, with: { (snapshot) -> Void in
            self.count = 0
            
            for itemSnapshot in snapshot.children {
                self.count += 1
                let a = (itemSnapshot as! FIRDataSnapshot).value as! NSDictionary
                print(self.count)

                //(planName : String, id: Int, detail : String, startTime : String, endTime : String)
                let item = format(planName : a["planName"] as! String,id : a["id"]  as! Int,
                                 detail : a["detail"]  as! String,
                                 startTime : a["startTime"] as! String ,
                                 endTime: a["endTime"] as! String )
                //   print()
                self.names.append(item)
                
                self.tableView.insertRows(at: [IndexPath(row: self.names.count-1,section: 0)], with: UITableViewRowAnimation.automatic)
            }
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

extension FormatViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if names==nil{
            return 0
        }else{
            return names.count }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.txtGroupName.text = names[indexPath.row].planName
        
        return cell }
    
}

extension FormatViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
    }
    
}

