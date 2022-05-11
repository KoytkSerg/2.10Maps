//
//  ViewController.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 6/1/22.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var googleMapView: UIView!
    @IBOutlet weak var appleMapView: UIView!


    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var appleTopConst: NSLayoutConstraint!
    @IBOutlet weak var appleHeightConst: NSLayoutConstraint!
    @IBOutlet weak var appleWidthConst: NSLayoutConstraint!
    @IBOutlet weak var googleHeightConst: NSLayoutConstraint!
    @IBOutlet weak var googleWidthConst: NSLayoutConstraint!
    @IBOutlet weak var googleBottomConst: NSLayoutConstraint!
    
    var appleMap = AppleViewController()
    var googleMap = GoogleViewController()

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let am = segue.destination as? AppleViewController, segue.identifier == "aMap"{
            appleMap = am
            am.delegate = self
        }
        if let gm = segue.destination as? GoogleViewController, segue.identifier == "gMap"{
            googleMap = gm
            gm.delegate = self
        }
    }
    // функции для тапа по картам
    @objc func appleMapHasTap(_ sender: UITapGestureRecognizer){
        openView.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.appleTopConst.constant = 0
            self.appleWidthConst.constant = UIScreen.main.bounds.width
            self.appleHeightConst.constant = UIScreen.main.bounds.height
            self.googleMapView.isHidden = true
            self.appleMap.buttonsViewSetings(false)
            self.view.layoutIfNeeded()
        }

    }
    
    @objc func goodleMapHasTap(_ sender: UITapGestureRecognizer){
        openView.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.googleBottomConst.constant = 0
            self.googleWidthConst.constant = UIScreen.main.bounds.width
            self.googleHeightConst.constant = UIScreen.main.bounds.height
            self.appleMapView.isHidden = true
            self.googleMap.buttonsViewSetings(false)
            self.view.layoutIfNeeded()
        }
    }
    
    func defaultLayoutSettings(){
        googleWidthConst.constant = UIScreen.main.bounds.width * 0.9
        googleHeightConst.constant = UIScreen.main.bounds.height / 3
        googleBottomConst.constant = UIScreen.main.bounds.height * 0.1
        
        appleTopConst.constant = UIScreen.main.bounds.height * 0.1
        appleWidthConst.constant = UIScreen.main.bounds.width * 0.9
        appleHeightConst.constant = UIScreen.main.bounds.height / 3
        
    }
    // создания тапа по картам
    func appleMapTap(){
        let appleTap = UITapGestureRecognizer(target: self, action: #selector(self.appleMapHasTap(_:)))
        appleMapView.addGestureRecognizer(appleTap)
        appleMapView.isUserInteractionEnabled = true
    }
    
    func googleMapTap(){
        let googleTap = UITapGestureRecognizer(target: self, action: #selector(self.goodleMapHasTap(_:)))
        self.openView.addGestureRecognizer(googleTap)
        openView.isUserInteractionEnabled = true
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultLayoutSettings()
        appleMapTap()
        googleMapTap()
    }


}
// делегат для закрытия большой карты
extension ViewController: BackButtonTap{
    func isTaped() {
        appleMap.buttonsViewSetings(true)
        googleMap.buttonsViewSetings(true)
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.defaultLayoutSettings()
            self.view.layoutIfNeeded()
        }completion: { (isComplited) in
            self.googleMapView.isHidden = false
            self.appleMapView.isHidden = false
            self.openView.isHidden = false
        }
    }
}
