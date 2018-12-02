//
//  GlobalFunctions.swift
//  Ronfle
//
//  Created by Soso on 30/11/2018.
//  Copyright © 2018 Soso. All rights reserved.
//

import Foundation

//fonction INSERT
func global_InsertDb (key: String,value: String){
    
    print ("You called a global insert func with param: ",key,value)
    
    //get local 'db' paths
    let path = Bundle.main.path(forResource: "database", ofType: "plist")
    //print(path!)
    let url = URL(fileURLWithPath: path!)
    
    //read existing MutableDictionary (var dict)
    let dict = NSMutableDictionary(contentsOf: url)
    let keyName = dict?.allKeys
    let keyValue = dict?.allValues
    
    //handle existing entries
    guard let dictSize = dict?.count else{return}
    //print("Size of dictionarry: ", dictSize)
    for i in 0..<dictSize {
        //print(i)
        //re-insert existing entries
        dict?.setValue(keyValue?[i], forKey: keyName![i] as! String)
    }
    //finally insert our new value
    dict?.setValue(value, forKey: key)
    dict?.write(to: url, atomically: true)
    print ("La chaine finale est: ",dict?.allKeys, dict?.allValues)
}


//fonction ACTIVE_SESSION
func global_CheckSession () {
    //Check if loggedin
    let path = Bundle.main.path(forResource: "database", ofType: "plist")
    //print(path!)
    let url = URL(fileURLWithPath: path!)
    //print(url.absoluteString)
    let obj = NSDictionary(contentsOf: url)
    
    
    if let str = obj!.value(forKey: "SESSION_ACTIVE") {
        //print("You call a global func checksession")
        guard let check = str as? String else {return}
        if check == "" {
            print("There is no SESSION_ACTIVE")
        }else {
            print("one user is loggedin: ", check)
            //go to profile page XXXXX
        }
    }
}



