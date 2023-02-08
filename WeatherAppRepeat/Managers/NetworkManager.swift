//
//  NetworkManager.swift
//  WeatherAppRepeat
//
//  Created by Timur Mannapov on 2023/2/5.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func fetchWeather(_ lat: Double, _ lon: Double, completion: @escaping (Weather) -> Void)
    func parseJSON(data: Data) -> Weather?
}

class NetworkManager: NetworkManagerProtocol {
    
    func fetchWeather(_ lat: Double, _ lon: Double, completion: @escaping (Weather) -> Void) {
    
        let string = "\(urlString)lat=\(lat)&lon=\(lon)"
        guard let url = URL(string: string) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: httpHeader)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self]  data, _, error in
        
            guard let data = data, error == nil else { return }
        
            if let weather = self?.parseJSON(data: data) {
                completion(weather)
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> Weather? {
        
        let decoder = JSONDecoder()
        do {
            let obj = try  decoder.decode(WeatherModel.self, from: data)
            guard let weather = Weather(weather: obj) else { return nil }
            return weather
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
