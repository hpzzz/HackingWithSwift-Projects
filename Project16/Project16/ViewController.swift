//
//  ViewController.swift
//  Project16
//
//  Created by Karol Harasim on 17/09/2019.
//  Copyright © 2019 Karol Harasim. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Change view", style: .plain, target: self, action: #selector(changeView))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = UIColor(ciColor: .blue)
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
//        let placeInfo = capital.info
        
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedCity = placeName
            
            navigationController?.pushViewController(vc, animated: true)
        }

//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
    }
    
    @objc func changeView() {
        let ac = UIAlertController(title: "Change map style", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "SatelliteFlyover", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "HybridFlyover", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func setMapType(action: UIAlertAction) {
        switch action.title {
        case "Standard":
            mapView.mapType = .standard
        case "Satellite":
            mapView.mapType = .satellite
        case "Hybrid":
            mapView.mapType = .hybrid
        case "SatelliteFlyover":
            mapView.mapType = .satelliteFlyover
        case "HybridFlyover":
            mapView.mapType = .hybridFlyover
        default:
            mapView.mapType = .standard
        }
    }
}

