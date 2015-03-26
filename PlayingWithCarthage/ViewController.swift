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
  
  var inmateList: [Inmate] = []
  
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
    Alamofire.request(.GET, url)
      .responseJSON { (request, response, data, error) in
        if error != nil {
          NSLog("Error: \(error)")
          println(request)
          println(response)
        } else {
          NSLog("Success: \(url)")
          var inmates = JSON(data!)
          
          for (index: String, json: JSON) in inmates {
            var inmate = Inmate()
            inmate.firstName = (json["FirstName"].stringValue as NSString).capitalizedString
            inmate.lastName = (json["LastName"].stringValue as NSString).capitalizedString
            inmate.middleName = (json["MiddleName"].stringValue as NSString).capitalizedString
            inmate.vineURL = json["VineURL"].stringValue
            inmate.imageURL = json["ImageFull"].stringValue
            inmate.thumbURL = json["ImageThumb"].stringValue
            
            for (aIndex: String, arrest: JSON) in json["Arrests"] {
              inmate.arrests.append(Arrest(Agency: arrest["Agency"].stringValue, ArrestDate: arrest["ArrestDate"].stringValue))
            }
            
            for (cIndex: String, charge: JSON) in json["Charges"] {
              inmate.charges.append(Charge(StatuteCode: charge["StatuteCode"].stringValue, StatuteDesc: charge["StatuteDesc"].stringValue))
            }
            self.inmateList.append(inmate)
          }
          
          println(self.inmateList.count)
          println(self.inmateList[0].arrests[0].arrestDate)
          println("\(self.inmateList[0].charges[0].statuteCode)- \(self.inmateList[0].charges[0].statuteDesc)")
        }
    }
  }
  
}

