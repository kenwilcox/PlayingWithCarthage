//
//  ViewController.swift
//  PlayingWithCarthage
//
//  Created by Kenneth Wilcox on 3/25/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func testFecth(sender: AnyObject) {
    Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
      .response { (request, response, data, error) in
        println(request)
        println(response)
        println(error)
    }
  }

}

