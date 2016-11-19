//
//  MapView.swift
//  GoogleMapMarkers
//
//  Created by n3deep on 18.11.16.
//  Copyright © 2016 n3deep. All rights reserved.
//

import UIKit
import GoogleMaps

class MapView: GMSMapView, CLLocationManagerDelegate {

    func drawRandomMarkers(latitude: CLLocationDegrees,longitude: CLLocationDegrees, howMany: Int, radiusFromMyLocation: Int) {
            for _ in 1...howMany {
                let markerCoordinates = generateRandomMarker(myLocationCoordinates: CLLocationCoordinate2D(latitude: latitude,longitude: longitude), radiusFromMyLocation: Double(radiusFromMyLocation))
                let position = markerCoordinates
            
                self.addRandomMarker(position: position)
            }
    }

    //helper method
    func generateRandomMarker(myLocationCoordinates: CLLocationCoordinate2D, radiusFromMyLocation: Double) -> CLLocationCoordinate2D {
        
        let x0 = myLocationCoordinates.longitude
        let y0 = myLocationCoordinates.latitude
        
        // Convert Radius from meters to degrees.
        let rd = radiusFromMyLocation/111300
        
        let u = Double(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
        let v = Double(CGFloat(Float(arc4random()) / Float(UINT32_MAX)))
        
        let w = rd * sqrt(u)
        let t = 2 * Double.pi * v
        let x = w * cos(t)
        let y = w * sin(t)
        
        let xp = x/cos(y0)
        
        return CLLocationCoordinate2D(latitude: y+y0,longitude: xp+x0)
    }
    
    //markers
    func addMyMarker(position: CLLocationCoordinate2D, circleRadius: CLLocationDistance ) {
        let marker = GMSMarker(position: position)
        marker.title = "My position"
        marker.icon = GMSMarker.markerImage(with: UIColor.green)
        marker.map = self
        
        //optional
        let cirlce = GMSCircle(position: self.camera.target, radius: circleRadius)
        cirlce.fillColor = UIColor.blue.withAlphaComponent(0.1)
        cirlce.map = self
    }
    
    func addRandomMarker(position: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            let marker = GMSMarker(position: position)
            marker.title = "Random marker"
            marker.icon = GMSMarker.markerImage(with: UIColor.gray)
            marker.map = self
        }
    }
}
