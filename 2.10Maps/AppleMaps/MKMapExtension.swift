//
//  MKMapExtension.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 6/1/22.
//

import Foundation
import MapKit

extension MKMapView {
    
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
      let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
          setRegion(coordinateRegion, animated: true)
    }
    
    func zoom(plus: Bool) -> ([Bool]){
        var res = [true, true]
        if plus{
            var dist = self.region.span
            dist.latitudeDelta *= 0.5
            dist.longitudeDelta *= 0.5
            if dist.latitudeDelta >= 0.001{
            let region = MKCoordinateRegion(center: self.centerCoordinate, span: dist)
                setRegion(region, animated: true)
                res[0] = true
                print(res)
            } else {
                res[0] = false
            }
        } else {
            var dist = self.region.span
            dist.latitudeDelta *= 2
            dist.longitudeDelta *= 2
            if dist.latitudeDelta <= 160{
                let region = MKCoordinateRegion(center: self.centerCoordinate, span: dist)
                setRegion(region, animated: true)
                res[1] = true
            } else {
                res[1] = false
            }
        }
        print(res)
        return res
    }
}
