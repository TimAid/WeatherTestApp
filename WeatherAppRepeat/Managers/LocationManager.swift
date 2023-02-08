//
//  LocationManager.swift
//  WeatherAppRepeat
//
//  Created by Timur Mannapov on 2023/2/6.
//

import Foundation
import CoreLocation

//MARK: - LocationManager

class LocationManager {
    
    var weatherManager = NetworkManager()
    /*
     перебераем массив с названиями городов а также с индексами, чтобы данные были правильными
     получаем локацию города, координаты
     дергаем погоду для города с lat & log координатами
     передаем в completion индекс города и его погоду
     */
    func setLocation(array: [String], completion: @escaping (Int, Weather) -> Void) {
        for (index, item) in array.enumerated() {
            getLocation(item) { location, error in
                guard let location = location, error == nil else { return }
                self.weatherManager.fetchWeather(location.latitude, location.longitude) { weather in
                    completion(index, weather)
                }
            }
        }
    }
    
    /// Get city location
    func getLocation(_ cityName: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        CLGeocoder().geocodeAddressString(cityName) { placemark, error in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
}
