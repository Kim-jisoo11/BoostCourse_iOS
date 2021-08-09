//
//  ViewController.swift
//  Assign3_Weather
//
//  Created by 김지수 on 2021/08/08.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var countryTableView: UITableView!
  let countryCellIdentifier : String = "CountryTableViewCell"
  var countries : [CountryListDataModel] = []
  var selectedCountry : String = ""
  var selectedTitle : String = ""
  
  // MARK : LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.countryTableView.delegate = self
    self.countryTableView.dataSource = self
    self.navigationItem.title = "세계날씨"
    
    
    let jsonDecoder : JSONDecoder = JSONDecoder()
    guard let dataAsset : NSDataAsset = NSDataAsset(name: "countries") else {
      return
    }
    
    do {
      self.countries = try jsonDecoder.decode([CountryListDataModel].self, from: dataAsset.data)
    } catch {
      print(error.localizedDescription)
    }
    self.countryTableView.reloadData()
  }
  
  
}

extension ViewController : UITableViewDelegate {
  
}
extension ViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 95
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.countries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell : CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.countryCellIdentifier, for: indexPath) as! CountryTableViewCell
    let country : CountryListDataModel = self.countries[indexPath.row]
    
    ///해당하는 국가의 국기 img 파일명에 맞게 불러오기
    if let image = UIImage(named : "flag_\(country.assetName)")
    {
      cell.countryImageView.image = image
    }
    cell.countryLabel?.text = country.koreanName
    cell.countryLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    ///선택된 열 회색에서 흰색으로 돌아오게
    tableView.deselectRow(at: indexPath, animated: true)
    ///다음 스토리보드로 넘어가기
    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CountryViewController") as? CountryViewController else {return}
    let country : CountryListDataModel = self.countries[indexPath.row]
    
    ///만약 selectedCountry가 비어있다면 더해주고, 내용이 있다면 삭제 후 넣어주도록
    if selectedCountry == "" {
      self.selectedCountry.append(country.assetName)
      self.selectedTitle.append(country.koreanName)
    } else {
      self.selectedCountry.removeAll()
      self.selectedTitle.removeAll()
      self.selectedCountry.append(country.assetName)
      self.selectedTitle.append(country.koreanName)
    }
    ///nextVC에다가 선택된 selectedCountry전달해주기
    nextVC.selectedCountry = self.selectedCountry
    nextVC.selectedTitle = self.selectedTitle
    
    self.navigationController?.pushViewController(nextVC, animated: true)
  }
  
}
