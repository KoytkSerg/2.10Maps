//
//  AppleViewController.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 6/1/22.
//

import UIKit
import MapKit
import CoreLocation

protocol BackButtonTap{
    func isTaped()
}

class AppleViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var locateButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButton(_ sender: Any) {
        delegate?.isTaped()
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        if mapView.zoom(plus: true)[0]{
            plusButton.isEnabled = true
            minusButton.isEnabled = true
        } else {
            plusButton.isEnabled = false
        }
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        if mapView.zoom(plus: false)[1]{
            plusButton.isEnabled = true
            minusButton.isEnabled = true
        } else {
            minusButton.isEnabled = false
        }
        
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        mapView.centerToLocation(currentLocation)
        minusButton.isEnabled = true
        plusButton.isEnabled = true
        print("locations = \(currentLocation.coordinate.latitude) \(currentLocation.coordinate.longitude)")
    }
    
    
    
    var delegate: BackButtonTap?
    let locationManager = LocationManager()
    var currentLocation = CLLocation()
    
    func buttonsViewSetings(_ bool: Bool){
//        heightConst.constant = UIScreen.main.bounds.width/6
        minusButton.isHidden = bool
        plusButton.isHidden = bool
        locateButton.isHidden = bool
        backButton.isHidden = bool
//        placesButton.isHidden = bool
        if bool {
            plusButton.alpha = 0
            minusButton.alpha = 0
            locateButton.alpha = 0
            backButton.alpha = 0
//            placesButton.alpha = 0
        }
        else {
            plusButton.alpha = 1
            minusButton.alpha = 1
            locateButton.alpha = 1
            backButton.alpha = 1
//            placesButton.alpha = 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.LCCheck(self)

        buttonsViewSetings(true)
        mapView.centerToLocation(CLLocation(latitude: 48.50786, longitude: 32.25042), regionRadius: 9000)
        mapView.addAnnotations(Places().places)
        mapView.delegate = self
        
        mapView.register(PlacesMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

    }

}

extension AppleViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        guard let place = view.annotation as? PointOfInterest else {
          return
        }

        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        place.mapItem?.openInMaps(launchOptions: launchOptions)
      }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let place = view.annotation as? PointOfInterest else {
          return
        }
        let location = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        mapView.centerToLocation(location, regionRadius: 300)
    }
}

extension AppleViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
    }
}
