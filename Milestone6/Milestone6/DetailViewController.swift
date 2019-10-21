//
//  DetailViewController.swift
//  Milestone6
//
//  Created by Karol Harasim on 19/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var countryName: String?
    var countryRegion: String?
    var countrySubregion: String?
    
//    var countryIndependent: Bool?
//    var countryCapital: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = countryName

        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Detail", for: indexPath)
//        var details = [countryName, countryRegion, countrySubregion]
//        var dic = ["Name": countryName, "region": countryRegion, "subregion": countrySubregion]
//        print(dic.description)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "lolek"
        return cell
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
