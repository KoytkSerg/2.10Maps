//
//  GoogleViewController.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 6/1/22.
//

import UIKit
import GoogleMaps
import CoreLocation

class GoogleViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var locateButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var placesButton: UIButton!

    
    @IBAction func backButton(_ sender: Any) {
        delegate?.isTaped()
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        let camera = mapView.camera.target
        mapView.camera = GMSCameraPosition(target: camera, zoom: mapView.camera.zoom + 1)

    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        let camera = mapView.camera.target
        mapView.camera = GMSCameraPosition(target: camera, zoom: mapView.camera.zoom - 1)
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        mapView.camera = GMSCameraPosition(target: currentLocation, zoom: 10)
    }
    
    var delegate: BackButtonTap?
    let locationManager = LocationManager()
    var currentLocation = CLLocationCoordinate2D()
    
    func buttonsViewSetings(_ bool: Bool){
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
        mapView.camera = GMSCameraPosition(latitude: 48.5154030, longitude: 32.2357250, zoom: 11)
        mapView.isMyLocationEnabled = true

    }

}

extension GoogleViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        currentLocation = locValue
    }
}
