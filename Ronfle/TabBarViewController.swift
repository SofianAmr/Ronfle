//
//  TabBarViewController.swift
//  Ronfle
//
//  Created by Soso on 30/11/2018.
//  Copyright © 2018 Soso. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        //self.tabBarItem![1] = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        

        // Do any additional setup after loading the view.
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
