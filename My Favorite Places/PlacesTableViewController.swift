//
//  PlacesTableViewController.swift
//  My Favorite Places
//
//  Created by Lorman Lau on 9/14/17.
//  Copyright © 2017 Lorman Lau. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class PlacesTableViewController: UITableViewController {
    
    var places = [Place]()
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    weak var delegate: MapDelegate?
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
            delegate?.cancel()
    }
    
    func fetchAllPlaces(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
        do {
            let result = try moc.fetch(request)
            places = result as! [Place]
        } catch {
            print("\(error)")
        }
    }
    
    func save() {
        print("Saving")
        if moc.hasChanges {
            do {
                try moc.save()
                print("save successful")
            } catch {
                print("\(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllPlaces()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as! PlaceCell
        cell.nameLabel.text = places[indexPath.row].name
        var cost = ""
        for _ in 0..<Int(places[indexPath.row].cost) {
            cost += "$"
        }
        cell.costLabel.text = "Cost: \(cost)"
        var hearts = ""
        for _ in 0..<Int(places[indexPath.row].hearts) {
            hearts += "<3"
        }
        cell.heartLabel.text = "Favorite: \(hearts)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let object = places[indexPath.row]
        moc.delete(object)
        save()
        places.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let controller = navController.topViewController as! AddItemViewController
        controller.delegate = self
    }
}

extension PlacesTableViewController: placeDelegate {
    
    func save(name: String, desc: String, cost: Int, hearts: Int, lat: Double, lon: Double) {
        let place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: moc) as! Place
        place.name = name
        place.desc = desc
        place.cost = Double(cost)
        place.hearts = Double(hearts)
        place.lat = lat
        place.lon = lon
        save()
        places.append(place)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
