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
  @IBOutlet weak var detailText: UITextView!
  @IBOutlet weak var imageView: UIImageView!
  
  var inmate: Inmate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if inmate != nil {
      nameLabel.text = "\(inmate.firstName) \(inmate.middleName) \(inmate.lastName)"
      
      var detail = "Arrest:\n"
      for (arrest:Arrest) in inmate.arrests {
        detail += "\(arrest.arrestDate)\n"
      }
      
      detail += "\nCharges:\n"
      for (charge:Charge) in inmate.charges {
        detail += "\(charge.statuteCode)\n\t\(charge.statuteDesc)\n"
      }
      
      detail += "\nVINE Link:\n"
      detail += "\tTap here to Register for Victim Notification"//"\t\(inmate.vineURL)"
      
      detailText.text = detail
      detailText.textColor = UIColor.whiteColor()
      detailText.contentOffset = CGPoint(x: -10,y: -10)
      
      var gesture = UITapGestureRecognizer(target: self, action: Selector("userTappedOnLink:"))
      detailText.userInteractionEnabled = true
      detailText.addGestureRecognizer(gesture)
      
      Alamofire.request(.GET, inmate.imageURL).response() {
        (_, _, data, _) in
        
        let image = UIImage(data: data! as! NSData)
        self.imageView.image = image
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func userTappedOnLink(recognizer: UITapGestureRecognizer) {
    var url = NSURL(string: inmate.vineURL)!
    UIApplication.sharedApplication().openURL(url)
  }
}
