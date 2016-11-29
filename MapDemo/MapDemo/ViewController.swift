//
//  ViewController.swift
//  MapDemo
//
//  Created by Jonas Reinsch on 11.04.16.
//  Copyright © 2016 Jonas Reinsch. All rights reserved.
//

// guter Tipp für das Draggen
// see http://stackoverflow.com/a/11675587

import UIKit
import MapKit

private extension Selector {
    static let recenterButtonPressed = #selector(ViewController.recenterButtonPressed)
}

func degreeToRadian(angle:CLLocationDegrees) -> CGFloat{
    
    return (  (CGFloat(angle)) / 180.0 * CGFloat(M_PI)  )
    
}

//        /** Radians to Degrees **/

func radianToDegree(radian:CGFloat) -> CLLocationDegrees{
    
    return CLLocationDegrees(  radian * CGFloat(180.0 / M_PI)  )
    
}

// delays by delay seconds, then executes
// the closure block on the main thread
// example: delayOnMainQueue(3.4) { print("delayed hello") }
func delayOnMainQueue(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

class ViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    var recenterButton:UIBarButtonItem!
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        myLineRenderer.strokeColor = UIColor.redColor()
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    }
    
    var location:(Double, Double) = (0, 0)
    var poiTitle:String = ""
    init(title:String, location:(Double, Double)) {
        super.init(nibName: nil, bundle: nil)
        
        poiTitle = title
        self.location = location
        goalCoordinate = CLLocationCoordinate2DMake(location.0, location.1)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = poiTitle
        
        // for rendering the polyline
        mapView.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self


        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsBuildings = true
        mapView.pitchEnabled = false

        mapView.mapType = .Standard
        
        navigationController?.hidesBarsOnTap = true
        navigationController?.navigationBarHidden = false
        
        let continueButton = UIBarButtonItem(title: "Los", style: .Done, target: self, action: #selector(continuePressed))

        mapView.userLocation.title = "Hier sind Sie"
        
        addViews()
        layout()
        
        recenterButton = UIBarButtonItem(title: "Zentrieren", style: .Done, target: self, action: .recenterButtonPressed)
        
        toolbarItems = [continueButton]
        
        navigationController?.toolbarHidden = false
        
    }
    
    func recenterButtonPressed() {
        mapView.setUserTrackingMode(.FollowWithHeading, animated: true)
    }
    
    func segmentedControlChanged(c:UISegmentedControl) {
        if c.selectedSegmentIndex == 0 {
            mapView.mapType = .Standard
        } else {
            mapView.mapType = .Hybrid
        }
    }
    
    func continuePressed() {
        print("continue pressed")
        
        let flex = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let segmentedControl = UISegmentedControl(items: ["Karte", "Satellit"])
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), forControlEvents: .ValueChanged)

        navigationController?.setToolbarHidden(true, animated: true)
        
        delayOnMainQueue(0.1) {
            self.setUserTrackingMode()
            self.toolbarItems = [self.recenterButton, flex,
                                 
//                                 UIBarButtonItem(customView: segmentedControl)
                                 ]
        }
        

    }

    func mapView(mapView: MKMapView, didChangeUserTrackingMode mode: MKUserTrackingMode, animated: Bool) {
        switch(mode) {
        case .FollowWithHeading: navigationController?.setToolbarHidden(true, animated: true)
            print("changed to follow with heading")
        default: navigationController?.setToolbarHidden(false, animated: true)
            print("changed to other")
        }
    }
    
    func addViews() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        mapView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        mapView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        mapView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        mapView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
    }
    
    override func viewDidAppear(animated: Bool) {
        displayDestination()
        
        delayOnMainQueue(2) {
            self.displayUserLocation()
            self.drawRoute()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


let point1 = MKPointAnnotation()
let pointUser = MKPointAnnotation()
var goalCoordinate = CLLocationCoordinate2DMake(0, 0)
func displayDestination() {

    point1.coordinate = goalCoordinate
    point1.title = "Ziel"
    point1.subtitle = poiTitle
    mapView.addAnnotation(point1)
    mapView.selectAnnotation(point1, animated: true)
    
    // center & span of the map

    mapView.setRegion(MKCoordinateRegionMake(point1.coordinate, MKCoordinateSpanMake(0.005,0.005)), animated: true)
    }
    
    func displayUserLocation() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)

        mapView.showsUserLocation = true
        
        pointUser.coordinate = startingLocation!.coordinate
        pointUser.title = "Start"
        mapView.addAnnotation(pointUser)
        mapView.selectAnnotation(pointUser, animated: true)
        mapView.showsCompass = false
        mapView.showsScale = false

        self.mapView.showAnnotations([self.point1, self.pointUser], animated: true)
    }
    
    func focusToUser() {
        mapView.setRegion(MKCoordinateRegionMake(startingLocation!.coordinate, MKCoordinateSpanMake(0.002,0.002)), animated: true)
        }
    
    func setUserTrackingMode() {
        mapView.setUserTrackingMode(.FollowWithHeading, animated: true)
    }
    
    var myRoute:MKRoute!
    func drawRoute() {
         let directionsRequest = MKDirectionsRequest()
         let markUser = MKPlacemark(coordinate: pointUser.coordinate, addressDictionary: nil)
         let markDestination = MKPlacemark(coordinate: point1.coordinate, addressDictionary: nil)
         
         directionsRequest.source = MKMapItem(placemark: markUser)
         directionsRequest.destination = MKMapItem(placemark: markDestination)
         
         directionsRequest.transportType = MKDirectionsTransportType.Walking
         let directions = MKDirections(request: directionsRequest)
         
         directions.calculateDirectionsWithCompletionHandler({
         response, error in
         
         if error == nil {
         self.myRoute = response!.routes[0] as MKRoute
            
         self.mapView.addOverlay(self.myRoute.polyline)
            print(self.myRoute.polyline)
         }
         })
    }
}

var startingLocation:CLLocation?
extension ViewController:CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last!
        startingLocation = location
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

