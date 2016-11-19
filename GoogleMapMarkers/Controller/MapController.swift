//
//  MapController.swift
//  GoogleMapMarkers
//
//  Created by n3deep on 18.11.16.
//  Copyright © 2016 n3deep. All rights reserved.
//

import UIKit
import GoogleMaps
//import CoreLocation

class MapController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet var mapView: MapView!
    var locationManager = CLLocationManager()
    var myLocation = MyLocation.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        myLocation.radiusToSeeMarkers = 100
        myLocation.howManyMarkers = 100
        myLocation.cameraZoom = 18
    }

    @IBAction func showMyLocation(_ sender: Any) {
        mapView.clear()
        self.startLocationManager()
    }
    
    @IBAction func putMarkers(_ sender: Any) {
        mapView.drawRandomMarkers(latitude: myLocation.latitude, longitude: myLocation.longitude, howMany: myLocation.howManyMarkers, radiusFromMyLocation: myLocation.radiusToSeeMarkers)
    }
        
    func mapView(_ mapView: MapView, didTapMarker marker: GMSMarker!) -> Bool {
        let markerLocation = CLLocation(latitude: marker.position.latitude,longitude: marker.position.longitude)
        let distanceBetween: CLLocationDistance = markerLocation.distance(from: CLLocation(latitude: myLocation.latitude, longitude: myLocation.longitude))
        print("distance: \(distanceBetween)")
        
        let message = Message()
        message.onDistance(distance: Int(distanceBetween))
        return true
    }
}

extension MapController: CLLocationManagerDelegate {
    func startLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        
        let currentLocation: CLLocation = locations[locations.count-1]
        
        myLocation.latitude = currentLocation.coordinate.latitude
        myLocation.longitude = currentLocation.coordinate.longitude
        
        print("location changed!")
        print("latitude: \(myLocation.latitude)")
        print("longitude: \(myLocation.longitude)")
        
        mapView.camera = GMSCameraPosition.camera(withLatitude: myLocation.latitude, longitude: myLocation.longitude, zoom: myLocation.cameraZoom)
        
        let  position = CLLocationCoordinate2DMake(myLocation.latitude, myLocation.longitude)
        
        mapView.addMyMarker(position: position, circleRadius: CLLocationDistance(myLocation.radiusToSeeMarkers))
    }
}
