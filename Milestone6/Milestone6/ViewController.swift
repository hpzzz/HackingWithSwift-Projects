//
//  ViewController.swift
//  Milestone6
//
//  Created by Karol Harasim on 19/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit
struct CountryDetail: Codable {
    var common: String
}
struct Country: Codable {
    var name: CountryDetail
    var region: String
    var subregion: String
//    var independent: Bool
//    var capital: String
}

struct Countries: Codable {
    var countries: [Country]
}

class ViewController: UITableViewController {
    var country: Country?
    var countries = [Country]()
//    var countriesDetails = [CountryDetail]()
    var countryDetails: CountryDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = Bundle.main.url(forResource: "countries", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        print("lolek")
        if let jsonCountries = try? decoder.decode(Countries.self, from: json) {
            countries = jsonCountries.countries
        }
            tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        country = countries[indexPath.row]
        countryDetails = country?.name
        cell.textLabel?.text = countryDetails?.common
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.countryName = countries[indexPath.row].name.common
            vc.countryRegion = countries[indexPath.row].region
            vc.countrySubregion = countries[indexPath.row].subregion
//            vc.countryIndependent = country?.independent
//            vc.countryCapital = country?.capital
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

