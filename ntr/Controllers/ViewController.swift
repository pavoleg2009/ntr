//
//  ViewController.swift
//  ntr
//
//  Created by Oleg Pavlichenkov on 19/10/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var apiClient: ApiClient!
    var pos: PoinfOfSale!
    
    // MARK: Outlets
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateOpenedLabel: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var addressMapView: MKMapView!
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiClient = ApiClient.shared
        apiClient.getSearchResults { (pos, error) in
            if let error = error, !error.isEmpty {
                print("==== Error: \(error)")
            }
            
            if let pos = pos  {
                self.pos = pos
                self.populateView()
            }
        }
    }
    
    // MARK: Helpers
    func populateView() {
        idLabel.text = pos.id
        nameLabel.text = pos.name
        typeLabel.text = pos.type
        phoneLabel.text = pos.phone
        statusLabel.text = pos.status
        dateOpenedLabel.text = pos.dateOpenedString
        
        let streetAddress = "\(pos.address?.street ?? "") \(pos.address?.house ?? "")"
        addressTextView.text = """
        Address: \(streetAddress)
        Coordinates (lng; lat): \(pos.address?.gps_lng ?? 0); \(pos.address?.gps_lat ?? 0)
        """
        
        if let lng: CLLocationDegrees = pos.address?.gps_lng,
            let lat : CLLocationDegrees = pos.address?.gps_lat {
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            show(coordinate, with: "\(streetAddress)", on: addressMapView)
        }
        
        
    }
    
    func show(_ coordinate: CLLocationCoordinate2D, with title: String, on mapView: MKMapView) {
        //"gps_lat":56.233969,"gps_lng":43.388959
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
        
        mapView.mapType = .hybrid
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let radius: CLLocationDistance = 1000
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius, radius)
        mapView.setRegion(region, animated: true)
        
        
        
    }

    
    
}

