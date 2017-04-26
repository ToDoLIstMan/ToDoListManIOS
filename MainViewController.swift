//
//  MainViewController.swift
//  
//
//  Created by songmho on 2017. 4. 25..
//
//

import UIKit

class MainViewController: UIViewController {
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var btnDate: UIBarButtonItem!
    @IBOutlet weak var listView: UITableView!
    
    var titles1 = ["df1","df1","df1"]
    var titles2 = ["df2","df2","df2"]
    var titles3 = ["df3","df3","df3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.dataSource = self
        
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

    @IBAction func btnDateClicked(_ sender: Any) {
        
    }
    

    @IBAction func segmentedChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("hello")
            self.listView.reloadData()
            break
        case 1:
            print("hello again")
            self.listView.reloadData()
            break
        case 2:
            print("hello again and again")
            self.listView.reloadData()
            break
        default:
            return
        }
    }
}

extension MainViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return titles1.count
        case 1:
            return titles2.count
        case 2:
            return titles3.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = listView.dequeueReusableCell(withIdentifier: "WorkTableViewCell", for: indexPath) as! WorkTableViewCell
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.txtTitle.text = titles1[indexPath.row]
          
        case 1:
            cell.txtTitle.text = titles2[indexPath.row]
            
        case 2:
            cell.txtTitle.text = titles3[indexPath.row]
        default:
            break
        }
        return cell
    }
    
}

extension MainViewController:UITableViewDelegate{
    
}
