//
//  ViewController.swift
//  Project7
//
//  Created by Karol Harasim on 28/08/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditsTapped))
        
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(promptForFilter))
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        
        navigationItem.leftBarButtonItems = [filterButton, refreshButton]
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
            showError()
        }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        filteredPetitions = petitions
            tableView.reloadData()
    }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func creditsTapped() {
        let ac = UIAlertController(title: "Data comes from the\nWe The People API of the Whitehouse", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .default))
        present(ac, animated: true)
    }
    
    @objc func promptForFilter() {
        let ac = UIAlertController(title: "Enter word", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let word = ac?.textFields?[0].text else { return }
            self?.submit(word)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ filter: String) {
        let lowerFilter = filter.lowercased()
        filteredPetitions.removeAll(keepingCapacity: true)
        for petition in petitions{
            if petition.title.lowercased().contains(lowerFilter) || petition.body.lowercased().contains(lowerFilter){
                filteredPetitions.append(petition)
            }
            
        }
        tableView.reloadData()
    }
    
    @objc func refreshTapped() {
        filteredPetitions = petitions
        tableView.reloadData()
    }
}

