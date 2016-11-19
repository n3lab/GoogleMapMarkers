//
//  MyLocation.swift
//  GoogleMapMarkers
//
//  Created by n3deep on 19.11.16.
//  Copyright © 2016 n3deep. All rights reserved.
//

import UIKit
import GoogleMaps

class MyLocation {
    static let sharedInstance = MyLocation()
    
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    var radiusToSeeMarkers = Int()
    var howManyMarkers = Int()
    var cameraZoom = Float()
}
