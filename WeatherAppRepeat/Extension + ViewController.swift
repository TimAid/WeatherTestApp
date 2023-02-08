//
//  Extension + ViewController.swift
//  WeatherAppRepeat
//
//  Created by Timur Mannapov on 2023/2/7.
//

import Foundation
import UIKit

extension CityListTableViewController {
    
    //MARK: - ALert
    func showAlert(title: String, placeholer: String, completion: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textfield in
            textfield.placeholder = placeholer
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let textField = alertController.textFields?.first else { return }
            if let text = textField.text {
                completion(text.capitalized)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true)
    }
    
    
    /// configure searchViewController
    /// - Parameter searchViewController: UISearchController
    func configureSearchController(searchController: UISearchController) {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
extension CityListTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
         
        filterCityArray = cityArray.filter({
            $0.cityName.contains(searchText)
        })
        tableView.reloadData()
    }
}
