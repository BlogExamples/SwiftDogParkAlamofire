//
//  Search.swift
//  DogAPIExample
//
//  Created by JoshuaKuehn on 5/19/17.
//  Copyright © 2017 Joshua Kuehn. All rights reserved.
//

import Foundation
import Alamofire

typealias SearchComplete = (_ isSuccessful: Bool, _ dogParks: [DogPark]) -> Void

class Search {

  
  static func requestAllDogParks(completion: @escaping SearchComplete) {
    var dogParks: [DogPark] = []

    let headers = [
      "Authorization":"Token token=5f93476d86b171df78e093b222420bd7",
      ]
    
    Alamofire.request("http://localhost:3000/api/v1/dog_parks", headers: headers) // GET is the default HTTP method
      .validate() // Default statusCode validation is 200..<300
      .responseJSON() { response in
        
        if (response.result.error == nil) {
          debugPrint("HTTP Response Body: \(response.data)")
          if let values = response.result.value {
            dogParks = self.parse(values: values)
            completion(true, dogParks) // The request worked and we pass back the parsed results
          }
          
        }
        else {
          debugPrint("HTTP Request failed: \(response.result.error)")
          completion(false, dogParks) // The request failed
        }
        
      }
  }
  
  // Takes in the HTTP response data and returns a DogPark Array
  static func parse(values: Any) -> [DogPark] {
    var dogParks: [DogPark] = []
    
    // Attempting to cast the values property into an Array of Any
    guard let values = values as? [Any] else { return dogParks }
    
    // Evaluate each value from the values Any Array
    for value in values {
      //Cast the value from the values Array to a Dictionary
      if let resultDict = value as? [String: Any] {
        
        // Attempt to initialize an instance of DogPark with the dictionary
        do {
          let dogPark = try DogPark(json: resultDict)
          // If try is successful we'll append the results and continue as normal
          dogParks.append(dogPark)
        } catch {
          print("ERROR: \(error)")
        }
        
      }
    }
    
    // Returns an instance of DogPark Array
    return dogParks
  }

  
}
