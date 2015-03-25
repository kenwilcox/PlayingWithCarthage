//
//  ViewController.swift
//  PlayingWithCarthage
//
//  Created by Kenneth Wilcox on 3/25/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
    var url = "http://api.canyonco.org/Sheriff/CurrentArrest"
    Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders?.updateValue("application/json",forKey: "Accept")
    
    Alamofire.request(.GET, url)
      .validate(contentType: ["application/json"])
      //.validate(Accept: ["application/json"])
      .response { (request, response, data, error) in
        if error != nil {
          NSLog("Error: \(error)")
          println(request)
          println(response)
        } else {
          NSLog("Success: \(url)")
          var json = JSON(data!)
          //var name = json[0]["FirstName"].stringValue
          //println("name = \(name)")
//          for (key: String, subJson: JSON) in json {
//            var name = subJson["FirstName"].stringValue
//            println("name = \(name)")
//          }
          
          println(json.rawValue)
          
//          for (index: String, subJson: JSON) in json {
//            println(subJson.rawValue)
//          }
        }
    }
  }
  
}

