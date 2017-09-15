//
//  routeViewController.swift
//  My Favorite Places
//
//  Created by Lorman Lau on 9/14/17.
//  Copyright © 2017 Lorman Lau. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class routeViewController: UIViewController {
    
    weak var delegate: routeViewDelegate?
    var place: Place?
    
    let manager = CLLocationManager()
    var myLocation = CLLocationCoordinate2D()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.viewcancel()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        manager.delegate = self
        manager.startUpdatingLocation()
        mapView.showsUserLocation = true
        setThings()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setThings(){
        if let place = place {
            nameLabel.text = place.name
            descLabel.text = place.desc
            var cost = ""
            for _ in 0..<Int(place.cost) {
                cost += "$"
            }
            costLabel.text = cost
            var heart = ""
            for _ in 0..<Int(place.hearts) {
                heart += "<3"
            }
            heartLabel.text = heart
            let center = CLLocationCoordinate2DMake(place.lat, place.lon)
            let span = MKCoordinateSpanMake(0.03, 0.03)
            let region = MKCoordinateRegionMake(center, span)
            mapView.setRegion(region, animated: false)
            print("regin:", region)
            let pin = MKPointAnnotation()
            pin.coordinate = center
            mapView.addAnnotation(pin)
            
        }
    }

}

extension routeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blue
        polylineRenderer.lineWidth = 4
        return polylineRenderer
    }
}

extension routeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0]
        myLocation = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        manager.stopUpdatingLocation()
    }
}
