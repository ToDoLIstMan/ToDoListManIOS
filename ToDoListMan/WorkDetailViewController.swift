//
//  WorkDetailViewController.swift
//  ToDoListMan
//
//  Created by songmho on 2017. 4. 26..
//  Copyright © 2017년 tdl. All rights reserved.
//

import UIKit
import Firebase

class WorkDetailViewController: UIViewController {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var txtPeople: UITextView!
    @IBOutlet weak var txtDetail: UITextView!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var btnPostpone: UIButton!
    
    var w : work!
    var master : String = ""
    var myNum : Int = -1
    var curGroupUid : Int = -1
    var curDate : String = ""
    
    var postponeDate : String = ""
    override func viewWillAppear(_ animated: Bool) {
        if master != (FIRAuth.auth()?.currentUser?.uid)! {
            btnPostpone.isHidden = true
        }
        for i in 0...w.uId.count-1 {
            if w.uId[i] == (FIRAuth.auth()?.currentUser?.uid)!{
                self.myNum = i
            print(String(w.isDone[myNum]))
                if w.isDone[myNum] {       //했을 때
                    btnFinish.setTitle("취소", for: .normal)
                    
                }
                break
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = w.title
        self.txtTitle.text = w.title
        self.txtTime.text = w.startTime
        self.txtPeople.text = String(describing: w.name)
        self.txtDetail.text = w.detail
        
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToPostpone(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? PostponeViewController {
            self.postponeDate = sourceViewController.date
            
            let database = FIRDatabase.database()
            let ref = database.reference().child("work").child(String(curGroupUid)).child(self.postponeDate)
            ref.observeSingleEvent(of: .value, with: { (dataSnapShot) in
                if dataSnapShot.exists() {
                    ref.child(String(dataSnapShot.childrenCount)).setValue(["title": self.w.title,
                                                                            "detail": self.w.detail,
                                                                            "id": Int(dataSnapShot.childrenCount),
                                                                            "startTime": self.w.startTime,
                                                                            "endTime": self.w.endTime,
                                                                            "uId": self.w.uId,
                                                                            "name": self.w.name,
                                                                            "isDone": self.w.isDone
                        ])
                    
                } else {
                    ref.child("0").setValue(["title": self.w.title,
                                             "detail": self.w.detail,
                                             "id": 0,
                                             "startTime": self.w.startTime,
                                             "endTime": self.w.endTime,
                                             "uId": self.w.uId,
                                             "name": self.w.name,
                                             "isDone": self.w.isDone
                        ])
                    
                }
                let alertController = UIAlertController(title: "알림", message: "일정이 미뤄졌습니다.", preferredStyle: .alert)
                
                
                let saveAction = UIAlertAction(title: "확인", style: .default, handler: {
                    alert -> Void in
                    
                    
                    
                    self.dismiss(animated: true, completion: nil)
                })
                
                alertController.addAction(saveAction)
                
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }

    @IBAction func btnFinishclicked(_ sender: Any) {
        let database = FIRDatabase.database()
        let ref = database.reference().child("work").child(String(curGroupUid)).child(self.curDate)
        if !w.isDone[myNum] {       //안했을 때 -> 했을 때
            btnFinish.setTitle("취소", for: .normal)
            w.isDone[myNum] = true
            
        } else {        //했을 때 -> 안했을 때
            btnFinish.setTitle("완료", for: .normal)
            w.isDone[myNum] = false
        
        }
        
        ref.child(String(w.id)).updateChildValues(["isDone" : self.w.isDone])
        
        
    }

    @IBAction func btnPostponeClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segPostpone", sender: self)
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
