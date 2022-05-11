//
//  AppleMarkerView.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 6/1/22.
//

import MapKit
import Foundation

class PlacesMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let place = newValue as? PointOfInterest else {
        return
      }
        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
        mapsButton.setBackgroundImage(UIImage(named: "Map"), for: .normal)
        let infoImage = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
        infoImage.image = place.image
        rightCalloutAccessoryView = mapsButton
        leftCalloutAccessoryView = infoImage
        glyphImage = place.glyphImage
        markerTintColor = place.markerTintColor
        
        let detailLabel = UILabel()
        detailLabel.numberOfLines = 0
        detailLabel.font = detailLabel.font.withSize(12)
        detailLabel.text = place.discipline
        detailCalloutAccessoryView = detailLabel

    }
  }
}
