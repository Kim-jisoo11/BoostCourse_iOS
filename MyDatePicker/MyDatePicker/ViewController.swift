//
//  ViewController.swift
//  MyDatePicker
//
//  Created by 김지수 on 2021/08/06.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var dateLabel: UILabel!
  let dateFormatter: DateFormatter = {
    let formatter: DateFormatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    /// 원하는 대로 custom 하고 싶으면
    //formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
    return formatter
  }()
  
  @IBAction func dateValueChanged(_ sender: UIDatePicker) {
//    print("sd")
    let date: Date = self.datePicker.date
    let dateString: String = self.dateFormatter.string(from: date)
    self.dateLabel.text = dateString
    
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.datePicker.addTarget(self, action: #selector(self.dateValueChanged(_:)), for: UIControl.Event.valueChanged)
  }


}

