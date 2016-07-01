//
//  ViewController.swift
//  MapDemo
//
//  Created by Jonas Reinsch on 11.04.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    let mapView = MKMapView()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsBuildings = true
        mapView.setUserTrackingMode(.FollowWithHeading, animated: true)
        mapView.mapType = .Hybrid

        navigationController?.hidesBarsOnTap = true

        
        // layout
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        mapView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        mapView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        mapView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
        
        
        let  userTrackingButton = MKUserTrackingBarButtonItem(mapView: mapView)
        navigationController?.toolbarHidden = false
        toolbarItems = [userTrackingButton]

        mapView.userLocation.title = "Hier sind Sie"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(locations)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("changed")
        if status == .AuthorizedWhenInUse {
            print("ok")
        } else {
            print("not ok")
        }
    }
}

