//
//  ViewController.swift
//  iOSCTLibKit
//
//  Created by Robin Shen on 05/11/2022.
//  Copyright (c) 2022 Robin Shen. All rights reserved.
//

import UIKit
import iOSCTLibKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let result = HelloWorld().sayHi()
        print(result);
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

