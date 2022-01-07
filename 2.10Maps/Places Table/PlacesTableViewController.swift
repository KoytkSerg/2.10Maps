//
//  PlacesTableViewController.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 7/1/22.
//

import UIKit

protocol PlacesDelegate{
    func placeIsTapped(place: PointOfInterest)
}

class PlacesTableViewController: UIViewController {

    @IBOutlet weak var placesTable: UITableView!
    
    let places = Places().places
    var delegate: PlacesDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesTable.delegate = self
        placesTable.dataSource = self
        placesTable.layer.cornerRadius = 20

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}

extension PlacesTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlacesViewCell
        cell.cellIn(data: places[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = places[indexPath.row]
        delegate?.placeIsTapped(place: data)
    }
    
}
