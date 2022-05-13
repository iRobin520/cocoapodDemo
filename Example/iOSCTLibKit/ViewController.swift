//
//  ViewController.swift
//  iOSCTLibKit
//
//  Created by Robin Shen on 05/11/2022.
//  Copyright (c) 2022 Robin Shen. All rights reserved.
//

import UIKit
import RxSwift
import iOSCTLibKit

class ViewController: UIViewController {
    let helloWorld = HelloWorld()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let result = helloWorld.sayHi()
        print(result);
        
        print("-------------fetching task-------------")
        helloWorld.getTodoTask().subscribe(onNext: {[weak self](task) in
            print("-------------fetched task:-------------")
            print(task)
        }, onError: { error in
            print("-------------fetch task failed:-------------")
            print(error)
        }, onCompleted: {[weak self] in
            print("-------------fetch task completed-------------")
        }).disposed(by: bag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

