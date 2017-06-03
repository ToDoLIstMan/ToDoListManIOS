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
    var curGroup = 5
    var date = "2017-06-03"
    var curUserUid = ""
    var oldSeg = 0
    
    var curWork : work!
    
    var master : String = ""
    
    var titles1 : [work] = []
    var titles2 : [work] = []
    var titles3 : [work] = []
    
    var gName : [String] = []
    var gUid : [Int] = []
    let database = FIRDatabase.database()
    
    var Myposition : Int = -1
    
    //String name, String rank, List<Integer> groups, List<String> groupName, List<Integer> masterGroups, List<String> masterGroupName
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.curUserUid = (FIRAuth.auth()?.currentUser?.uid)!
        
        listView.dataSource = self
        listView.delegate = self
        
        
        getMygroup()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
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
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? TimePickerViewController {
            self.date = sourceViewController.date
            
            loadData(index: segmentedControl.selectedSegmentIndex, curGroup: self.curGroup)
            
        }
    }

    @IBAction func unwindFromList(segue:UIStoryboardSegue) {
        
        if let sourceViewController = segue.source as? GroupPickerViewController {
            self.curGroup = sourceViewController.pickGrpId
            
            
            loadData(index: segmentedControl.selectedSegmentIndex, curGroup:  self.curGroup)
        }
    }
    
    @IBAction func btnChangeGroup(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "segList", sender: self)
    }
    
    @IBAction func btnDateClicked(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "segDate", sender: self)
        
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segList" {
            let sendtimer=segue.destination as! GroupPickerViewController
            sendtimer.myGroup = self.gName
        }
        else {
            
        }
    }
    

    @IBAction func segmentedChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            loadData(index: 0,curGroup: self.curGroup)
            break
        case 1:
            loadData(index: 1,curGroup:  self.curGroup)
            break
        case 2:
            loadData(index: 2,curGroup:  self.curGroup)
            break
        default:
            return
        }
    }
    
    func getMygroup(){
        self.ref = FIRDatabase.database().reference()
        self.ref.child("user").child(self.curUserUid).observe(.value, with: { (snapShot) in
           // 그룹 없는거 체크해야 함.
            if snapShot.hasChildren() {
                let a = snapShot.value as! NSDictionary
                if a["groupName"] != nil {
                    self.gName = a["groupName"] as! [String]
                    self.gUid = a["groups"] as! [Int]
                    self.curGroup = self.gUid[0]
                    
                    self.ref.child("group").child(String(self.gUid[0])).observe(FIRDataEventType.value, with: { (dataSnapShot) in
                        var d = dataSnapShot.value as! NSDictionary
                        self.master = d["masterUid"] as! String
                        
                        self.loadData(index: self.segmentedControl.selectedSegmentIndex, curGroup: self.gUid[0])
                    })
                } else {
                    
                    let alertController = UIAlertController(title: "경고", message: "그룹을 추가하세요.", preferredStyle: .alert)
                    
                    
                    let saveAction = UIAlertAction(title: "확인", style: .default, handler: {
                        (action : UIAlertAction!) -> Void in
                        
                    })

                    alertController.addAction(saveAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
    
    func loadData(index : Int, curGroup : Int){
        self.ref = FIRDatabase.database().reference()
        self.ref.child("work").child(String(curGroup)).child(date).observe(.value, with: { (snapShot) in
            
            self.titles1.removeAll()
            if snapShot.exists() {
                var i = 0
                self.listView.reloadData()
                
                for itemSnapshot in snapShot.children {
                    self.oldSeg = index
                    let a = (itemSnapshot as! FIRDataSnapshot).value as! NSDictionary
                    var isdone = a["isDone"] as! [Bool]
                    print("가져오는 것 ", isdone.description)
                    
                    //int id, String title, String detail, String startTime, String endTime,List<String> name,List<String> uId,List<Boolean> isDone
                    let item = work(id: a["id"] as! Int,  title: a["title"] as! String, detail: a["detail"] as! String,
                                    startTime: a["startTime"] as! String, endTime: a["endTime"] as! String,
                                    name: a["name"] as! [String], uId: a["uId"] as! [String], isDone: a["isDone"] as! [Bool] )
                    if index == 0 {
                        self.titles1.append(item)
                        self.listView.insertRows(at: [IndexPath(row: self.titles1.count-1,section: 0)], with: UITableViewRowAnimation.automatic)
                    }
                    
                    else if index == 1 {
                        i = 0
                        for uid in (a["uId"] as! [String]) {
                            if uid == self.curUserUid {
                                if isdone[i] {
                                    self.titles1.append(item)
                                    self.listView.insertRows(at: [IndexPath(row: self.titles1.count-1,section: 0)], with: UITableViewRowAnimation.automatic)
                                }
                            }
                            
                            i += 1
                        }
                    }
                    
                    else if index == 2 {
                        i = 0
                        for uid in (a["uId"] as! [String]) {
                            if uid == self.curUserUid {
                                if !isdone[i] {
                                    self.titles1.append(item)
                                    self.listView.insertRows(at: [IndexPath(row: self.titles1.count-1,section: 0)], with: UITableViewRowAnimation.automatic)
                                }
                            }
                            
                            i += 1
                        }
                    }
                    
                }
            }else {
                
                self.listView.reloadData()
                print("없없")
            }
        })
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segDetail" {
            let sendtimer=segue.destination as! WorkDetailViewController
            sendtimer.w = work(id: curWork.id,  title: curWork.title, detail: curWork.detail, startTime : curWork.startTime,
                               endTime : curWork.endTime, name: curWork.name, uId: curWork.uId, isDone: curWork.isDone )
            sendtimer.master = self.master
            sendtimer.curGroupUid = self.curGroup
            sendtimer.curDate = self.date
            ref.removeAllObservers()
        } else if segue.identifier == "segList" {
            let sendtimer=segue.destination as! GroupPickerViewController
       //     sendtimer.myGroup =["dd","dd"]

        }
    }
}


extension MainViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return titles1.count
        case 1:
            return titles1.count
        case 2:
            return titles1.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        var isDone : Bool = false
        let cell = listView.dequeueReusableCell(withIdentifier: "WorkTableViewCell", for: indexPath) as! WorkTableViewCell
        var myNum = -1
        cell.btnDone.setImage(UIImage(named:"unchecked")?.withRenderingMode(.alwaysOriginal), for: .normal)
        cell.txtTitle.text = titles1[indexPath.row].title
        cell.txtTime.text = titles1[indexPath.row].startTime+" ~ "+titles1[indexPath.row].endTime
        cell.txtPeople.text = titles1[indexPath.row].name.joined(separator: " ")
        //      cell.btnDone.text = titles1[indexPath.row].
        
        for i in 0...((self.titles1[indexPath.row].uId.count)-1) {
            if self.titles1[indexPath.row].uId[i] == FIRAuth.auth()?.currentUser?.uid {
                myNum = i
                if self.titles1[indexPath.row].isDone[i] {
                    cell.btnDone.setImage(UIImage(named:"checked")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    print("일했음")
                    cell.isDone = true
                } else {
                    cell.btnDone.setImage(UIImage(named:"unchecked")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    print("일안했음")
                    cell.isDone = false
                    print(String(self.titles1[indexPath.row].isDone[i]))
                }
            }
        }

        cell.tapAction = { [weak self] (cell1) in
            let curGrpStr = self?.curGroup.description
            var grpNon = curGrpStr!
           let database = FIRDatabase.database()
            let ref = database.reference().child("work").child(grpNon).child((self?.date.description)!)
            
            if cell.isDone {
                cell.btnDone.setImage(UIImage(named:"unchecked")?.withRenderingMode(.alwaysOriginal), for: .normal)
                 self?.titles1[indexPath.row].isDone[myNum] = false
                cell.isDone = false
                
            } else {
                cell.btnDone.setImage(UIImage(named:"checked")?.withRenderingMode(.alwaysOriginal), for: .normal)
                
                self?.titles1[indexPath.row].isDone[myNum] = true
                cell.isDone = true
            }
            let idStr = self?.titles1[indexPath.row].id.description
            let idNon = idStr!
            ref.child(idNon).updateChildValues(["isDone" : self?.titles1[indexPath.row].isDone])

        }

        
        
        return cell
    }
    
}

extension MainViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        print("HI!",titles1[indexPath.row].title,"  ",titles1[indexPath.row].isDone.description)
        curWork = work(id: titles1[indexPath.row].id,  title: titles1[indexPath.row].title, detail: titles1[indexPath.row].detail, startTime:titles1[indexPath.row].startTime, endTime:titles1[indexPath.row].endTime, name: titles1[indexPath.row].name, uId: titles1[indexPath.row].uId, isDone: titles1[indexPath.row].isDone )
        
        
       
     
        self.performSegue(withIdentifier: "segDetail", sender: self)
        
        
    }
}


