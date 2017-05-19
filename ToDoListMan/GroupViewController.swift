//
//  GroupViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 26..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class GroupViewController: UIViewController {
    
    @IBOutlet weak var btnAddGroup: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var names: [group] = []
    var ref: FIRDatabaseReference!
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   FIRApp.configure()
        
        tableView.dataSource = self
        tableView.delegate = self as? UITableViewDelegate
        
        self.ref = FIRDatabase.database().reference()

        self.ref.child("group").observe(FIRDataEventType.value, with: { (snapshot) -> Void in
            self.count = 0
            
            for itemSnapshot in snapshot.children {
                self.count += 1
                let a = (itemSnapshot as! FIRDataSnapshot).value as! NSDictionary
                print(self.count)
                var memberName = [String?]()
                var memberUid = [String?]()
                
                var memberNameRst = [String]()
                var memberUidRst = [String]()

                if a["memberName"] != nil {
                    memberName = (a["memberName"] as! [String?]).flatMap { $0 }
                    for s : String? in memberName {
                        if s != nil {
                            memberNameRst.append(s!)
                        }
                    }
                    memberUid = (a["memberUid"] as! [String?]).flatMap { $0 }
                    for s : String? in memberName {
                        if s != nil {
                            memberUidRst.append(s!)
                        }
                    }
                }
               let item = group(groupName: a["groupName"] as! String,id: a["id"]  as! Int,
                                 masterUid: a["masterUid"]  as! String,
                                 memberName: memberNameRst ,
                                 memberUid: memberUidRst )
             //   print()
                self.names.append(item)
            
            self.tableView.insertRows(at: [IndexPath(row: self.names.count-1,section: 0)], with: UITableViewRowAnimation.automatic)
            }
        })
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      /*
        if editingStyle == .delete && isModi {
            names.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
 
 */
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

   
    @IBAction func AddGroupClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "그룹 만들기", message: "그룹명을 입력하세요.", preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        let saveAction = UIAlertAction(title: "확인", style: .default, handler: {
            alert -> Void in
            let dummy = [String]()
            let firstTextField = alertController.textFields![0] as UITextField
            
        
            self.ref.child("group").child(String(self.count)).setValue(["groupName":firstTextField.text,
                                                                "id":self.count,
                                                                "masterUid":FIRAuth.auth()?.currentUser?.uid])
            self.ref.child("group").child(String(self.count)).observe(.value, with: { (snapshot) in
           //     self.names.append(group(snapshot: snapshot as! FIRDataSnapshot))
            })
            self.tableView.beginUpdates()
            self.tableView.reloadData()
            self.tableView.endUpdates()
        
        })
        
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "그룹명"
        }
    
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
}

extension GroupViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if names==nil{
            return 0
        }else{
            return names.count }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.txtGroupName.text = names[indexPath.row].groupName
        
        return cell }
    
    }

extension GroupViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        print(indexPath.row)
        let alertController = UIAlertController(title: names[indexPath.row].groupName, message: "참여하시겠습니까?", preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        let saveAction = UIAlertAction(title: "확인", style: .default, handler: {
            alert -> Void in
            
            
            
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}

