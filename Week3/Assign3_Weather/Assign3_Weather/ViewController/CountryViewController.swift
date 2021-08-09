//
//  CountryViewController.swift
//  Assign3_Weather
//
//  Created by 김지수 on 2021/08/08.
//

import UIKit

class CountryViewController: UIViewController {
  @IBOutlet weak var weatherTableView: UITableView!
  let weatherCellIdentifier : String = "WeatherTableViewCell"
  var weathers : [DetailWeatherDataModel] = []
  var selectedCountry : String = ""
  var selectedTitle : String = ""
  var statenum : String = ""
  var cityTitleName : String = ""
  var nextstate : String = ""
  var nextdegree : String = ""
  var nextrain : String = ""
  
  // MARK : LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.weatherTableView.delegate = self
    self.weatherTableView.dataSource = self
    self.navigationItem.title = self.selectedTitle
    
    let jsonDecoder : JSONDecoder = JSONDecoder()
    guard let dataAsset : NSDataAsset = NSDataAsset(name: "\(selectedCountry)") else {
      return
    }
    
    do {
      self.weathers = try jsonDecoder.decode([DetailWeatherDataModel].self, from: dataAsset.data)
    } catch {
      print(error)
    }
    self.weatherTableView.reloadData()
  }
}
extension CountryViewController : UITableViewDelegate {
  
}
extension CountryViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.weathers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    ///셀에 데이터 너헝주기
    let cell : WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.weatherCellIdentifier, for: indexPath) as! WeatherTableViewCell
    let weather : DetailWeatherDataModel = self.weathers[indexPath.row]
    cell.citynameLabel?.text = weather.cityName
    cell.rainfallLabel?.text = "강수확률\(weather.rainfallProbability)%"
    cell.degreeLabel?.text = "섭씨\(weather.celsius)도 / 화씨\(((weather.celsius)*9/5)+32)도"
    ///Label Font size & color  조절
    cell.citynameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    cell.rainfallLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    cell.degreeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    ///이미지 넣어주기
    if weather.state == 10 {
      statenum = "sunny"
    }
    if weather.state == 11 {
      statenum = "cloudy"
    }
    if weather.state == 12 {
      statenum = "rainy"
    }
    if weather.state == 13 {
      statenum = "snowy"
    }
    if let image = UIImage(named: statenum) {
      cell.weatherImageView.image = image
    }
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    ///선택된 열 회색에서 흰색으로 돌아오게
    tableView.deselectRow(at: indexPath, animated: true)
    ///다음 화면으로 넘어가기
    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "DetailweatherViewController") as? DetailweatherViewController else {return}
    ///넘길 때 데이터 저장해서 넘겨주기
    let weather : DetailWeatherDataModel = self.weathers[indexPath.row]
    if cityTitleName == "" {
      cityTitleName.append(weather.cityName)
    } else {
      cityTitleName.removeAll()
      cityTitleName.append(weather.cityName)
    }
    nextVC.cityTitleName = self.cityTitleName
    if nextstate == "" {
      nextstate.append("\(weather.state)")
    } else {
      nextstate.removeAll()
      nextstate.append("\(weather.state)")
    }
    if nextdegree == "" {
      nextdegree.append("\(weather.celsius)")
    } else {
      nextdegree.removeAll()
      nextdegree.append("\(weather.celsius)")
    }
    if nextrain == "" {
      nextrain.append("\(weather.rainfallProbability)")
    } else {
      nextrain.removeAll()
      nextrain.append("\(weather.rainfallProbability)")
    }
    nextVC.nextstate = self.nextstate
    nextVC.nextdegree = self.nextdegree
    nextVC.nextrain = self.nextrain
    self.navigationController?.pushViewController(nextVC, animated: true)
  }  
}
