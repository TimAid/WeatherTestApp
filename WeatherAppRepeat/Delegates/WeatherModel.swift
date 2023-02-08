//
//  Weather.swift
//  WeatherAppRepeat
//
//  Created by Timur Mannapov on 2023/2/5.
//

import Foundation
//MARK: - WeatherModel
struct WeatherModel: Decodable {
    
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
    
    //MARK: - Info
    struct Info : Decodable {
        let url: String
    }
    
    //MARK: - Fact
    struct Fact: Decodable {
        let temp: Double
        let condition: String
        let icon: String
        let windSpeed: Double
        let pressureMm: Int
        let pressurePa: Int
        
        enum CodingKeys: String, CodingKey {
            case temp, condition, icon 
            case windSpeed = "wind_speed"
            case pressureMm = "pressure_mm"
            case pressurePa = "pressure_pa"
        }
    }
    
    //MARK: - Forecast
    struct Forecast: Decodable {
        let parts: Parts
    }
    
    //MARK: - Parts
    struct Parts: Codable {
        let day: Day
    }
    
    //MARK: - Day
    struct Day: Codable {
        
        let tempMin, tempMax: Int?
        
        enum CodingKeys: String, CodingKey {
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
}
