//
//  Places.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 6/1/22.
//

import Foundation
import MapKit

class Places{
    var places: [PointOfInterest] = [
        PointOfInterest(title: "Дендропарк", locationName: "Кропевницкий", discipline: "парк", coordinate: CLLocationCoordinate2D(latitude: 48.50041, longitude: 32.23235), image: UIImage(named: "place1")),
        PointOfInterest(title: "Горсад", locationName: "Кропевницкий", discipline: "парк", coordinate: CLLocationCoordinate2D(latitude: 48.48505, longitude: 32.25532), image: UIImage(named: "place2")),
        PointOfInterest(title: "Площадь Героев Майдана", locationName: "Кропевницкий", discipline: "площадь", coordinate: CLLocationCoordinate2D(latitude: 48.51005, longitude: 32.26663), image: UIImage(named: "place3")),
        PointOfInterest(title: "Ангел-хранитель Украины", locationName: "Кропевницкий", discipline: "скульптура", coordinate: CLLocationCoordinate2D(latitude: 48.51850, longitude: 32.27497), image: UIImage(named: "place4")),
        PointOfInterest(title: "крепость Елисаветграда", locationName: "Кропевницкий", discipline: "памятник", coordinate: CLLocationCoordinate2D(latitude: 48.49819, longitude: 32.25398), image: UIImage(named: "place5"))
                                      
    ]
    
}
