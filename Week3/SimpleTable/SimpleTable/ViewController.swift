//
//  ViewController.swift
//  SimpleTable
//
//  Created by 김지수 on 2021/08/08.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  let cellIdentifier : String = "cell"
  let customCellIdentifier : String = "customCell"
  
  let Korean : [String] = ["가","나","다","라","마","바"]
  let English : [String] = ["A","B","C","D","E","F"]
  var dates : [Date] = []
  let dateFormatter : DateFormatter = {
    let formatter : DateFormatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
  }()
  let timeFormatter : DateFormatter = {
    let formatter : DateFormatter = DateFormatter()
    formatter.timeStyle = .medium
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self

  }
  
  @IBAction func addButtonClicked(_ sender: Any) {
    dates.append(Date())
    
    /// 필요한 section만 reload 하도록
    self.tableView.reloadSections(IndexSet(2...2), with: UITableView.RowAnimation.automatic)
  }
  
  
}

extension ViewController : UITableViewDelegate {
  
}
extension ViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0 :
      return Korean.count
    case 1 :
      return English.count
    case 2 :
      return dates.count
    default :
      return 0
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section < 2 {
      let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
      let text : String = indexPath.section == 0 ? Korean[indexPath.row] : English[indexPath.row]
      cell.textLabel?.text = text
      return cell
    }
    else {
      let cell : CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.customCellIdentifier, for: indexPath) as! CustomTableViewCell
      cell.leftLabel.text = self.dateFormatter.string(from: self.dates[indexPath.row])
      cell.rightLabel.text = self.timeFormatter.string(from: self.dates[indexPath.row])
      return cell
    }
  }
  
    func numberOfSections(in tableView: UITableView) -> Int {
      return 3
    }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Korean"
    }
    if section == 1 {
      return "English"
    }
    if section == 2 {
      return "Date"
    }
    return nil
  }
  
  
}

