//
//  ViewController.swift
//  pushmynotifs
//
//  Created by Jurjen on 20/12/2016.
//  Copyright © 2016 Jurjen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        FIRMessaging.messaging().subscribe(toTopic: "/topics/news")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

