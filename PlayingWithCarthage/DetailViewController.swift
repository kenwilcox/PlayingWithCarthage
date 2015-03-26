//
//  DetailViewController.swift
//  PlayingWithCarthage
//
//  Created by Kenneth Wilcox on 3/25/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  
  var inmate: Inmate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if inmate != nil {
      nameLabel.text = "\(inmate.firstName) \(inmate.middleName) \(inmate.lastName)"
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
