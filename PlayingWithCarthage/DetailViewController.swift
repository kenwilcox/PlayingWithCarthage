//
//  DetailViewController.swift
//  PlayingWithCarthage
//
//  Created by Kenneth Wilcox on 3/25/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  var inmate: Inmate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if inmate != nil {
      //nameLabel.text = "\(inmate.firstName) \(inmate.middleName) \(inmate.lastName)"
      
      Alamofire.request(.GET, inmate.imageURL).response() {
        (_, _, data, _) in
        
        let image = UIImage(data: data! as NSData)
        self.imageView.image = image
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
