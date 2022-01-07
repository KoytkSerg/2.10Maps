//
//  PointOfInterest.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 6/1/22.
//

import Foundation
import MapKit
import Contacts

class PointOfInterest: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let image: UIImage?
    let locationName: String?
    let discipline: String?
  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D,
    image: UIImage?
  ) {
      self.title = title
      self.locationName = locationName
      self.discipline = discipline
      self.coordinate = coordinate
      self.image = image

      super.init()
  }
    // go to maps
  var mapItem: MKMapItem? {
      guard let location = locationName else {
      return nil
      }

      let addressDict = [CNPostalAddressStreetKey: location]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }

    var markerTintColor: UIColor  {
      switch discipline {
      case "парк":
        return .green
      case "площадь":
        return .cyan
      case "памятник":
        return .blue
      case "скульптура":
        return .purple
      default:
        return .red
      }
    }
    var glyphImage: UIImage {
      guard let name = discipline else {
        return UIImage(named: "Flag")!
      }
      switch name {
      case "парк":
        return UIImage(named: "park")!
      case "площадь":
        return UIImage(named: "square")!
      case "скульптура":
        return UIImage(named: "sculpture")!
      case "памятник":
        return UIImage(named: "monument")!
      default:
        return UIImage(named: "Flag")!
      }
    }
    
}
