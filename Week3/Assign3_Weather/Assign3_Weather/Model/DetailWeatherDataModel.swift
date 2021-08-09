//
//  DetailWeatherDataModel.swift
//  Assign3_Weather
//
//  Created by 김지수 on 2021/08/08.
//

import Foundation

// MARK: - DetailWeatherElement[
struct DetailWeatherDataModel : Codable {
  let cityName : String
  let state : Int
  let celsius : Float
  let rainfallProbability : Int
  
  enum CodingKeys : String, CodingKey {
    case state, celsius
    case cityName = "city_name"
    case rainfallProbability = "rainfall_probability"
  }
  
}

