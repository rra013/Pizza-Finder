//
//  ViewController.swift
//  Pizza Finder
//
//  Created by Rishi Anand on 7/11/18.
//  Copyright © 2018 Rishi Anand. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var region = MKCoordinateRegion()
    
    
    let locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        locManager.delegate = self
        locManager.startUpdatingLocation()
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.025, 0.025)
        region = MKCoordinateRegionMake(center, span)
        mapView.setRegion(region, animated: true)
    }

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "pizza"
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response{
                for mapItem in response.mapItems{
                    print(mapItem.name!)
                }
            }
        }
    }
}

