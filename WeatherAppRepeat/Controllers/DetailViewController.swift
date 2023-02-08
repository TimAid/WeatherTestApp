//
//  DetailViewController.swift
//  WeatherAppRepeat
//
//  Created by Timur Mannapov on 2023/2/7.
//

import UIKit
import SwiftSVG

class DetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    var weatherData: Weather?
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLabels()
    }

    private func configureLabels() {
        guard let modelInfo = weatherData else { return }
        
        cityNameLabel.text = modelInfo.cityName
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(modelInfo.conditionCode).svg") else { return }
        
        DispatchQueue.main.async { [weak self] in
            let imageView = SVGView(SVGURL: url) { (image) in
                image.boundingBox = CGRect(x: 0, y: 0, width: 22, height: 22)
                image.resizeToFit((self?.iconView.bounds)!)
            }
            self?.iconView.addSubview(imageView)
        }
        
        statusLabel.text = modelInfo.conditionString.capitalized
        temperatureLabel.text = modelInfo.tempString
        pressureLabel.text = "\(modelInfo.pressureMm)"
        windSpeedLabel.text = String(describing: modelInfo.windSpeed)
        minTempLabel.text = "\(modelInfo.tempMin)"
        maxTempLabel.text = "\(modelInfo.tempMax)"
    }
}
