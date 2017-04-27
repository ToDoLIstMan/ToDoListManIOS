//
//  GroupViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 26..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    var names = ["group #1","group #2","group #3"]
    @IBOutlet weak var btnAddGroup: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self as! UITableViewDelegate
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
            
            let firstTextField = alertController.textFields![0] as UITextField
            self.names.append(firstTextField.text!)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: (self.names.count-1), section: 0)], with: .automatic)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return names.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        cell.txtGroupName.text = names[indexPath.row]
        
        return cell }
    
    }

extension GroupViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        print(indexPath.row)
        let alertController = UIAlertController(title: names[indexPath.row], message: "참여하시겠습니까?", preferredStyle: .alert)
        
        
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

