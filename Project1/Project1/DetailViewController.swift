//
//  DetailViewController.swift
//  Project1
//
//  Created by Karol Harasim on 12/08/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var totalPictures = 0
    var selectedPicNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picture \(selectedPicNumber) of \(totalPictures)"
        navigationItem.largeTitleDisplayMode = .never
        
        assert(selectedImage != nil)
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
