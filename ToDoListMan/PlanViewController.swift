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
    
    var sections = ["포맷 설정","일 추가"]
    var aa = ["그룹선택 ","포맷선택","당번선택"]
    var aaa = ["dd","asdf","asdf"]
    
    
    
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
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    @IBAction func sendClicked(_ sender: Any) {
    }
    
}

extension PlanViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return self.sections[section]
        }
        else {
            return self.sections[section]
        }

    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return aa.count
        }
        else {
            return aaa.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        if indexPath.section == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTableFormatViewCell", for: indexPath) as! PlanTableFormatViewCell
            //set the data here
            cell.txtTitle.text = aa[indexPath.row]
            cell.btnGotoDetail.titleLabel?.text = "추가"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTableAddViewCell", for: indexPath) as! PlanTableAddViewCell
            
            cell.txtTest.text = aaa[indexPath.row]
            return cell
        }
 
    }
    
}

extension PlanViewController:UITableViewDelegate{
    
}


