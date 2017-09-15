//
//  AddItemViewController.swift
//  My Favorite Places
//
//  Created by Lorman Lau on 9/14/17.
//  Copyright © 2017 Lorman Lau. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddItemViewController: UIViewController {
    
    weak var delegate: placeDelegate?
    let manager = CLLocationManager()
    var myLocation = CLLocationCoordinate2D()
    var region = MKCoordinateRegion()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var costButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!

    @IBAction func heartButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            sender.tag += 1
            sender.setTitle("<3<3", for: .normal)
            break
        case 2:
            sender.tag += 1
            sender.setTitle("<3<3<3", for: .normal)
            break
        case 3:
            sender.tag += 1
            sender.setTitle("<3<3<3<3", for: .normal)
            break
        case 4:
            sender.tag += 1
            sender.setTitle("<3<3<3<3<3", for: .normal)
            break
        case 5:
            sender.tag = 1
            sender.setTitle("<3", for: .normal)
            break
        default:
            sender.setTitle("<3", for: .normal)
            sender.tag = 1
        }
    }
    
    @IBAction func costButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            sender.tag += 1
            sender.setTitle("$$", for: .normal)
            break
        case 2:
            sender.tag += 1
            sender.setTitle("$$$", for: .normal)
            break
        case 3:
            sender.tag += 1
            sender.setTitle("$$$$", for: .normal)
            break
        case 4:
            sender.tag += 1
            sender.setTitle("$$$$$", for: .normal)
            break
        case 5:
            sender.tag = 1
            sender.setTitle("$", for: .normal)
            break
        default:
            sender.setTitle("$", for: .normal)
            sender.tag = 2
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancel()
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        delegate?.save(name: name.text!, desc: desc.text!, cost: costButton.tag, hearts: heartButton.tag, lat: mapView.centerCoordinate.latitude, lon: mapView.centerCoordinate.longitude)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        mapView.delegate = self
        manager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AddItemViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0]
        myLocation = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        region = MKCoordinateRegionMake(myLocation, span)
        mapView.showsUserLocation = true
        mapView.setRegion(region, animated: false)
        self.manager.stopUpdatingLocation()
    }
}

extension AddItemViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let pins = mapView.annotations
        let center = MKPointAnnotation()
        center.coordinate = mapView.centerCoordinate
        mapView.removeAnnotations(pins)
        mapView.addAnnotation(center)
    }
}
