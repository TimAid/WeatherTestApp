//
//  CityListTableViewController.swift
//  WeatherAppRepeat
//
//  Created by Timur Mannapov on 2023/2/5.
//

import UIKit
import CoreLocation
class CityListTableViewController: UITableViewController {
    
    //MARK: - Properties
    var networkManager = NetworkManager()
    var locationManager = LocationManager()
    var emptyCityArray = Weather()
    var nameOfCities = ["Москва", "Уфа", "Учалы", "Челябинск", "Санкт-Петербург", "Чжоушань", "Пекин", "Токио", "Минск", "Лос Анджелес"]
    
    /// куда попадают отфильтрованные города
    var filterCityArray = [Weather]()
    
    var cityArray = [Weather]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCities()
        configureSearchController(searchController: searchController)
    }
    
    //MARK: - Methods
    private func addCities() {
        
        if cityArray.isEmpty {
            cityArray = Array(repeating: emptyCityArray, count: nameOfCities.count)
        }
        
        locationManager.setLocation(array: self.nameOfCities) { [self] (index, weather) in
            cityArray[index] = weather
            cityArray[index].cityName = nameOfCities[index]
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailVC" {
            guard let indexpath = tableView.indexPathForSelectedRow else { return }
            let cityInfo = cityArray[indexpath.row]
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.weatherData = cityInfo
        }
    }
    
    //MARK: - IBAction
    @IBAction func addButtonPressed(_ sender: Any) {
        
        showAlert(title: "Добавить город", placeholer: "Город") { [weak self] newCity in
            guard let strongSelf = self else { return }
            if let city = newCity {
                self?.nameOfCities.append(city)
                self?.cityArray.append(strongSelf.emptyCityArray)
                self?.addCities()
            }
        }
    }
}


// MARK: - Tableview datasource & Delegate
extension CityListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            
            return filterCityArray.count
        }
        return cityArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityListCell else { return UITableViewCell() }
        
        var cityWeather = Weather()
        
        if isFiltering {
            cityWeather = filterCityArray[indexPath.row]
        } else {
            cityWeather = cityArray[indexPath.row]
        }
        
        cell.configureCell(cityWeather)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if self.isFiltering {
                filterCityArray.remove(at: indexPath.row)
            } else {
                cityArray.remove(at: indexPath.row)
            }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
}


