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
    95
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
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CountryViewController") as? CountryViewController else {return}
///어떤 나라의 것을 눌렀는지 그 에셋 네임을 저장해서 같이 넘겨주어야 함!
    ///전역 변수 만들어서 빈 문자열 만들어 놓고 거기에다가 에셋 네임을 넣어서 넘겨주면 될것같음!
    self.navigationController?.pushViewController(nextVC, animated: true)
  }
  
}
