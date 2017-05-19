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
    var names:[String] = []
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
        
        self.ref.child("format").child((FIRAuth.auth()?.currentUser?.uid)!).observe(FIRDataEventType.value, with: { (snapshot) -> Void in
            self.count = 0
            for itemSnapshot in snapshot.children {
                self.count += 1
                
                self.names.append((itemSnapshot as! FIRDataSnapshot).key as String!)
                
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormatTableViewCell", for: indexPath) as! FormatTableViewCell
        cell.txtFormatName.text = names[indexPath.row]
        return cell }
    
    
}

extension FormatViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
    }
    
}

