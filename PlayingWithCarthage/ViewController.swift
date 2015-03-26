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
  
  @IBOutlet weak var tableView: UITableView!
  var refreshControl:UIRefreshControl!
  var inmateList: [Inmate] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.refreshControl = UIRefreshControl()
    self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
    self.tableView.addSubview(refreshControl)
    
    loadInmateList()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func refresh(sender:AnyObject)
  {
    loadInmateList()
  }
  
  func loadInmateList() {
    var url = "http:api.canyonco.org/Sheriff/CurrentArrest"
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    Alamofire.request(.GET, url)
      .responseJSON { (request, response, data, error) in
        if error != nil {
          NSLog("Error: \(error)")
          println(request)
          println(response)
        } else {
          NSLog("Success: \(url)")
          UIApplication.sharedApplication().networkActivityIndicatorVisible = false
          var inmates = JSON(data!)
          
          for (index: String, json: JSON) in inmates {
            var inmate = Inmate()
            inmate.idNumber = json["IDNumber"].stringValue
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
          
          self.refreshControl.endRefreshing()
          self.tableView.reloadData()
        }
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "toDetail" {
      if sender != nil {
        var detailVC = segue.destinationViewController as DetailViewController
        detailVC.inmate = sender as? Inmate
      }
    }
  }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return inmateList.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
    let inmate = self.inmateList[indexPath.row]
    cell.textLabel?.text = "\(inmate.firstName) \(inmate.middleName) \(inmate.lastName)"
    cell.detailTextLabel?.text = "Arrests: \(inmate.arrests.count)  Charges: \(inmate.charges.count)"
    cell.imageView?.image = UIImage(named: "Placeholder.png")
    //println(inmate.thumbURL)
    Alamofire.request(.GET, inmate.thumbURL).response() {
      (_, _, data, _) in
      
      let image = UIImage(data: data! as NSData)
      cell.imageView?.image = image
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var inmate = self.inmateList[indexPath.row]
    self.performSegueWithIdentifier("toDetail", sender: inmate)
  }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
//  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
//  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 64
  }
  
//  func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String {
//  }
}

