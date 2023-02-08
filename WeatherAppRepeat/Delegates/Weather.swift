//
//  Weather.swift
//  WeatherAppRepeat
//
//  Created by Timur Mannapov on 2023/2/6.
//

import Foundation


class Weather {
    
    //MARK: - Properties
    var cityName: String = ""
    var status: String = ""
    var temp: Double = 0.0
    var tempString: String {
        return String(format: "%0.f", temp)
    }
    var conditionCode: String = ""
    var condition: String = ""
    var tempMin: Int = 0
    var tempMax: Int = 0
    var windSpeed: Double = 0.0
    var pressureMm: Int = 0
    var presurePa: Int = 0
    
    var conditionString: String {
        switch condition {
        case "clear":                   return  "ясно"
        case "partly-cloudy":           return "малооблачно"
        case "cloudy":                  return "облачно с прояснениями"
        case "overcast":                return  "пасмурно"
        case "drizzle":                 return "морось"
        case "light-rain":              return  "небольшой дождь"
        case "rain":                    return  "дождь"
        case "moderate-rain":           return "умеренно сильный дождь"
        case "heavy-rain":              return "сильный дождь"
        case "continuous-heavy-rain":   return "длительный сильный дождь"
        case "showers":                 return "ливень"
        case "wet-snow":                return "дождь со снегом"
        case "light-snow":              return "небольшой снег"
        case "snow":                    return "снег"
        case "snow-showers":            return "снегопад"
        case "hail":                    return "град"
        case "thunderstorm":            return "гроза"
        case "thunderstorm-with-rain":  return "дождь с грозой"
        case "thunderstorm-with-hail":  return "гроза с градом"
        default:                        return "Загрузка..."
        }
    }
  
    
    init?(weather: WeatherModel?) {
        guard let model = weather else { return }
        status = model.fact.condition
        temp = model.fact.temp
        windSpeed = model.fact.windSpeed
        presurePa = model.fact.pressurePa
        pressureMm = model.fact.pressureMm
        tempMax = (model.forecasts.first?.parts.day.tempMax)!
        tempMin = (model.forecasts.first?.parts.day.tempMin)!
        condition = model.fact.condition
        conditionCode = model.fact.icon
    }
    
    init() {
        
    }
}
