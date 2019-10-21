//
//  ViewController.swift
//  Project4
//
//  Created by Karol Harasim on 19/08/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UITableViewController {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Site", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedPage = websites[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

