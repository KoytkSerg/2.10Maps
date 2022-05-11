//
//  GoogleViewController.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 6/1/22.
//

import UIKit
import GoogleMaps


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
    let places = Places().places
    // подпись на делегат для действий с таблици с местами
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlacesTableViewController, segue.identifier == "goToPlaces"{
            vc.delegate = self
        }
    }
    
//    функция для добавления маркеров на карту
    func googlePlaces(places: [PointOfInterest]){
        for i in places{
            let marker = GMSMarker()
            marker.title = i.title
            marker.snippet = i.discipline
            marker.position = i.coordinate
            marker.map = mapView
            marker.icon = i.glyphImage
            marker.setIconSize(scaledToSize: .init(width: 30, height: 30))
            marker.groundAnchor = CGPoint(x: 0.5, y: 1)
            marker.appearAnimation = .pop
        }
    }
    //    анимированное ищезание или появления кнопок на карте при раскрытии или закрытии
    func buttonsViewSetings(_ bool: Bool){
        minusButton.isHidden = bool
        plusButton.isHidden = bool
        locateButton.isHidden = bool
        backButton.isHidden = bool
        placesButton.isHidden = bool
        if bool {
            plusButton.alpha = 0
            minusButton.alpha = 0
            locateButton.alpha = 0
            backButton.alpha = 0
            placesButton.alpha = 0
        }
        else {
            plusButton.alpha = 1
            minusButton.alpha = 1
            locateButton.alpha = 1
            backButton.alpha = 1
            placesButton.alpha = 1
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.LCCheck(self)
        buttonsViewSetings(true)
        googlePlaces(places: places)
        mapView.camera = GMSCameraPosition(latitude: 48.5154030, longitude: 32.2357250, zoom: 11)
        mapView.isMyLocationEnabled = true

    }

}
extension GoogleViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.camera = GMSCameraPosition(target: marker.position, zoom: 15)
        print(marker.title!)
        return false
    }
}

extension GoogleViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        currentLocation = locValue
    }
}

extension GoogleViewController: PlacesDelegate{
    func placeIsTapped(place: PointOfInterest) {
        mapView.camera = GMSCameraPosition(target: place.coordinate, zoom: 15)

    }
}
// уменшение маркера
extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}
