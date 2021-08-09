//
//  DetailweatherViewController.swift
//  Assign3_Weather
//
//  Created by 김지수 on 2021/08/08.
//

import UIKit

class DetailweatherViewController: UIViewController {
  @IBOutlet weak var weatherImageView: UIImageView!
  @IBOutlet weak var weatherTitleLabel: UILabel!
  @IBOutlet weak var degreeLabel: UILabel!
  @IBOutlet weak var rainfallLabel: UILabel!
  var cityTitleName : String = ""
  var nextstate : String = ""
  var nextdegree : String = ""
  var nextrain : String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = cityTitleName
    ///기상 예보 타이틀
    if nextstate == "10" {
      self.weatherTitleLabel.text = "해가 쩅쨍"
      if let image = UIImage(named: "sunny") {
        self.weatherImageView.image = image
      }
    }
    if nextstate == "11" {
      self.weatherTitleLabel.text = "구름이 구름구름"
      if let image = UIImage(named: "cloudy") {
        self.weatherImageView.image = image
      }
    }
    if nextstate == "12" {
      self.weatherTitleLabel.text = "비가 주륵주륵"
      if let image = UIImage(named: "rainy") {
        self.weatherImageView.image = image
      }
    }
    if nextstate == "13" {
      self.weatherTitleLabel.text = "눈이 펑펑"
      if let image = UIImage(named: "snowy") {
        self.weatherImageView.image = image
      }
    }
    ///온도 변환
    guard let floatDegree = Float(nextdegree) else { return }
    let CeltoF = ((floatDegree)*9/5)+32
    self.degreeLabel.text = "섭씨\(nextdegree)도 / 화씨\((round(CeltoF*1000))/1000)도"
    self.rainfallLabel.text = "강수확률\(nextrain)%"
    ///font size & color
    self.weatherTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    self.degreeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    self.rainfallLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    ///강수량이 50 넘으면 오렌지
    if Int(nextrain) ?? 0 >= 50 {
      self.rainfallLabel.textColor = UIColor.orange
    } else {
      self.rainfallLabel.textColor = UIColor.black
    }
    ///기온이 10 밑으로 내려가면 블루
    if Float(nextdegree) ?? 0.0 <= 10 {
      self.degreeLabel.textColor = UIColor.blue
    } else {
      self.degreeLabel.textColor = UIColor.black
    }
  }
}
