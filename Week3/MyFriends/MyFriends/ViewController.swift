//
//  ViewController.swift
//  MyFriends
//
//  Created by 김지수 on 2021/08/08.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  let cellIdentifier : String = "cell"
  var friends : [Friend] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    
    let jsonDecoder : JSONDecoder = JSONDecoder()
    guard let dataAsset : NSDataAsset = NSDataAsset(name: "friends") else {
      return
    }
    
    do {
      self.friends = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
    } catch {
      print(error.localizedDescription)
    }
    self.tableView.reloadData()
  }


}

extension ViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.friends.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
    let friend : Friend = self.friends[indexPath.row]
    
    cell.textLabel?.text = friend.name + "(\(friend.age))"
    cell.detailTextLabel?.text = friend.address_info.city + "," + friend.address_info.country
    return cell
  }
}
