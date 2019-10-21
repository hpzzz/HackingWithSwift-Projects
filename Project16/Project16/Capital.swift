//
//  Capital.swift
//  Project16
//
//  Created by Karol Harasim on 17/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//
import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.coordinate = coordinate
        self.title = title
        self.info = info
    }
    

}
