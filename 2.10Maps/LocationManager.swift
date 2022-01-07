//
//  LocationManager.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 6/1/22.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager {
    let locationManager = CLLocationManager()
    
    func LCCheck(_ VC: CLLocationManagerDelegate){
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = VC
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
}
