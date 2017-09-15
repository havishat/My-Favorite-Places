//
//  PlacesTableViewController.swift
//  My Favorite Places
//
//  Created by Lorman Lau on 9/14/17.
//  Copyright © 2017 Lorman Lau. All rights reserved.
//

import UIKit
import CoreLocation

class PlacesTableViewController: UITableViewController, placeDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell")
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let controller = navController.topViewController as! AddItemViewController
        controller.delegate = self
    }
    
    func save(name: String, desc: String, cost: Int, hearts: Int, location: CLLocationCoordinate2D) {
        dismiss(animated: true, completion: nil)
    }
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
