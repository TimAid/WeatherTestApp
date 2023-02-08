//
//  CityListCell.swift
//  WeatherAppRepeat
//
//  Created by Timur Mannapov on 2023/2/6.
//

import UIKit

class CityListCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configureCell(_ weather: Weather) {
        nameCityLabel.text = weather.cityName
        statusLabel.text = weather.conditionString
        temperatureLabel.text = weather.tempString
    }
}
