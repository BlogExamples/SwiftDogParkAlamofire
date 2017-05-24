//
//  ViewController.swift
//  SwiftDogParkAlamofire
//
//  Created by JoshuaKuehn on 5/22/17.
//  Copyright © 2017 edu. All rights reserved.
//

import UIKit

class DogParkViewController: UIViewController {

  var tableView: UITableView = UITableView(frame: .zero)
  let cellIdentifier = "cell"
  
  var dogParks: [DogPark] = [] {
    didSet {
      guard self.dogParks.count > 0 else { return }
      self.tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView.dataSource = self
    
    self.view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
      tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -20)
      ])
    
    
    Search.requestAllDogParks() { isSuccessful, dogParks in
      if isSuccessful {
        self.dogParks = dogParks
      } else {
        // Let the user know the request failed
      }
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension DogParkViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel?.text = dogParks[indexPath.row].name
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return dogParks.count
  }

}

