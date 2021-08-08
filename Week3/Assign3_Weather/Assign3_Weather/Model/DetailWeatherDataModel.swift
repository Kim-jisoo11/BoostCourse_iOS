//
//  DetailWeatherDataModel.swift
//  Assign3_Weather
//
//  Created by 김지수 on 2021/08/08.
//

import Foundation

// MARK: - DetailWeatherElement
struct DetailWeatherElement: Codable {
    let cityName: String
    let state: Int
    let celsius: Double
    let rainfallProbability: Int

    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case state, celsius
        case rainfallProbability = "rainfall_probability"
    }
}

typealias DetailWeather = [DetailWeatherElement]
