//
//  MainViewController.swift
//  
//
//  Created by songmho on 2017. 4. 25..
//
//

import UIKit
import Firebase

class MainViewController: UIViewController {
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var btnDate: UIBarButtonItem!
    @IBOutlet weak var listView: UITableView!
    
    var ref: FIRDatabaseReference!
    var works :[work] = []
    var myGroups : [Int] = []
    var curGroup = "0"
    var date = "2017-05-20"
    var curUserUid = ""
    var oldSeg = 0
    
    var titles1 : [work] = []
    var titles2 : [work] = []
    var titles3 : [work] = []
    
    var gName : [String] = []
    var gUid : [Int] = []
    
    
    //String name, String rank, List<Integer> groups, List<String> groupName, List<Integer> masterGroups, List<String> masterGroupName
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FIRAuth.auth()?.currentUser?.uid)
        
        self.curUserUid = (FIRAuth.auth()?.currentUser?.uid)!
        
        listView.dataSource = self
        listView.delegate = self
        
        
        loadData(index: segmentedControl.selectedSegmentIndex)
        
        getMygroup()
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
    

    @IBAction func btnChangeGroup(_ sender: Any) {
        self.performSegue(withIdentifier: "segList", sender: self)
    }
    
    @IBAction func btnDateClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "segTime", sender: self)
        
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segList" {
            let sendtimer=segue.destination as! GroupPickerViewController
            sendtimer.myGroup = self.gName
            sendtimer.myGroupId = self.gUid
        }
        else {
            
        }
    }
    

    @IBAction func segmentedChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.listView.reloadData()
            break
        case 1:
            self.listView.reloadData()
            break
        case 2:
            self.listView.reloadData()
            break
        default:
            return
        }
    }
    
    func getMygroup(){
        self.ref = FIRDatabase.database().reference()
        self.ref.child("user").child(self.curUserUid).observe(.value, with: { (snapShot) in
            
                          
        })
    }
    
    
    func loadData(index : Int){
        switch self.oldSeg {
        case 0:
            self.titles1.removeAll()
            break;
        case 1:
            self.titles2.removeAll()
            break;
        case 2:
            self.titles3.removeAll()
            break;
        default:
            break;
        }

        self.ref = FIRDatabase.database().reference()
        self.ref.child("work").child(curGroup).child(date).observe(.value, with: { (snapShot) in
            if snapShot.exists() {
                var i = 0
                self.listView.reloadData()
                
                for itemSnapshot in snapShot.children {
                    self.oldSeg = index
                    let a = (itemSnapshot as! FIRDataSnapshot).value as! NSDictionary
                    var isdone = a["isDone"] as! [Bool]
                    
                    //int id, String title, String detail, String startTime, String endTime,List<String> name,List<String> uId,List<Boolean> isDone
                    let item = work(id: Int(self.curGroup) as! Int,  title: a["title"] as! String, detail: a["detail"] as! String,
                                    startTime: a["startTime"] as! String, endTime: a["endTime"] as! String,
                                    name: a["name"] as! [String], uId: a["uId"] as! [String], isDone: isdone )
                    
                    self.titles1.append(item)
                    i = 0
                    for uid in (a["uId"] as! [String]) {
                        if uid == self.curUserUid {
                            if isdone[i] {
                                self.titles2.append(item)
                            } else {
                                self.titles3.append(item)
                            }
                        }
                        
                        i += 1
                    }
                    
                    switch index {
                    case 0:
                        self.listView.insertRows(at: [IndexPath(row: self.titles1.count-1,section: 0)], with: UITableViewRowAnimation.automatic)
                        break;
                    case 1:
                        self.listView.insertRows(at: [IndexPath(row: self.titles2.count-1,section: 0)], with: UITableViewRowAnimation.automatic)
                        break;
                    case 2:
                        self.listView.insertRows(at: [IndexPath(row: self.titles3.count-1,section: 0)], with: UITableViewRowAnimation.automatic)
                        break;
                    default:
                        break;
                    }
                    
                }
            }else {
                print("없없")
            }
        })
        
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
            cell.txtTitle.text = titles1[indexPath.row].title
            cell.txtTime.text = titles1[indexPath.row].startTime+" ~ "+titles1[indexPath.row].endTime
            cell.txtPeople.text = titles1[indexPath.row].name.joined(separator: " ")
      //      cell.btnDone.text = titles1[indexPath.row].
          
        case 1:
            cell.txtTitle.text = titles2[indexPath.row].title
            cell.txtTime.text = titles2[indexPath.row].startTime+" ~ "+titles2[indexPath.row].endTime
            cell.txtPeople.text = titles2[indexPath.row].name.joined(separator: " ")
            //      cell.btnDone.text = titles2[indexPath.row].
            
        case 2:
            cell.txtTitle.text = titles3[indexPath.row].title
            cell.txtTime.text = titles3[indexPath.row].startTime+" ~ "+titles3[indexPath.row].endTime
            cell.txtPeople.text = titles3[indexPath.row].name.joined(separator: " ")
        //      cell.btnDone.text = titles3[indexPath.row].
        default:
            break
        }
        return cell
    }
    
}

extension MainViewController:UITableViewDelegate{
    
}


