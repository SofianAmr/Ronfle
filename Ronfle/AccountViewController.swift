//
//  AccountViewController.swift
//  Ronfle
//
//  Created by Soso on 30/11/2018.
//  Copyright © 2018 Soso. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var disconnect: UIButton!
    @IBOutlet weak var name: UILabel!
    
    var list = [""]
    
    @IBAction func logout(_ sender: Any) {
        //kill session active
        global_InsertDb(key: "SESSION_ACTIVE", value: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disconnect.layer.cornerRadius = 5.0
        disconnect.layer.masksToBounds = true
        
        // Get the current loggedin user
        let path = Bundle.main.path(forResource: "database", ofType: "plist")
        print(path!)
        let url = URL(fileURLWithPath: path!)
        let obj = NSDictionary(contentsOf: url)
        
        if let str = obj!.value(forKey: "SESSION_ACTIVE") {
            print("The Active session is : ",str as Any)
            guard let str = str as? String else{return}
            name.text = ("Welcome "+str+"!")
        }
        
        
        if let savedSleeps = obj!.value(forKey: "SLEEP") {
            guard let savedSleeps = savedSleeps as? String else {return}
            print("saved sleeps in database : \(savedSleeps)")
            
            list = [savedSleeps]
           
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
