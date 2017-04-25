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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        case 1:
            print("hello again")
        case 2:
            print("hello again and again")
        default:
            return
        }
    }
}
