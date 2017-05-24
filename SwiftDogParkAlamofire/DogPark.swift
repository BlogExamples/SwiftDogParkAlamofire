//
//  DogPark.swift
//  DogAPIExample
//
//  Created by JoshuaKuehn on 5/19/17.
//  Copyright © 2017 Joshua Kuehn. All rights reserved.
//

import Foundation

enum SerializationError: Error {
  case missing(String)
}

struct DogPark {
  var name: String
  
  init(json: [String: Any]) throws {
    guard let name = json["name"] as? String else {
      throw SerializationError.missing("name")
    }
    self.name = name
  }
}
