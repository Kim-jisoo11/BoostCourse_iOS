//
//  CountryListDataModel.swift
//  Assign3_Weather
//
//  Created by 김지수 on 2021/08/08.
//

import Foundation

// MARK: - CountryElement
struct CountryListDataModel : Codable {
  let koreanName : String
  let assetName : String
  
  enum CodingKeys : String, CodingKey {
    case koreanName = "korean_name"
    case assetName = "asset_name"
  }
}
