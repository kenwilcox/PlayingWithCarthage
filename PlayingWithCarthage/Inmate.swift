//
//  Inmate.swift
//  PlayingWithCarthage
//
//  Created by Kenneth Wilcox on 3/25/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation

class Inmate {
  var idNumber: String!
  var firstName: String!
  var lastName: String!
  var middleName: String!
  var vineURL: String!
  var arrests: [Arrest] = []
  var charges: [Charge] = []
  var imageURL: String!
  var thumbURL: String!
  
  init() {
    
  }
}