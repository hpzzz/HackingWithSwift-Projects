//
//  ViewController.swift
//  Milestone 6: Projects 13-15
//
//  Created by Karol Harasim on 19/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        urlString = "https://raw.githubusercontent.com/mledoze/countries/master/countries.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCountries = try? decoder.decode(Countries.self, from: json) {
            countries = jsonCountries.results
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.official
        return cell
    }
}

