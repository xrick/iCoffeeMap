//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 20/7/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var tableView : UITableView!
    var mapView : MKMapView!
    
    var restaurant:CoffeeShopMO!//Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantImageView.image = UIImage(data: restaurant.image as! Data)
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red: 240.0/255, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        title = restaurant.name
        tableView.estimatedRowHeight = 36.0;
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.mapView = MKMapView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 140))
        self.mapView.mapType = .standard
        
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(showMap))
        
        self.mapView.addGestureRecognizer(tapGestureRecognizer)
        
        setMapViewAnnotation(self.mapView, _location: restaurant.location!, _animated: true)
        
        self.tableView.tableFooterView = self.mapView
        
    }
    
    func showMap(){
        performSegue(withIdentifier: "showMap", sender: self)
    }
    
    private func setMapViewAnnotation(_ _mapView:MKMapView, _location : String, _animated: Bool)
    {
        // set geo data
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location!, completionHandler: {
            placemarks, error in
            if error != nil{
                print(error)
                return
            }
            
            if let placemakers = placemarks{
                let placemark = placemarks?[0]
                
                // add annotation
                let annotation = MKPointAnnotation()
                if let location = placemark?.location {
                    annotation.coordinate = location.coordinate
                    _mapView.addAnnotation(annotation)
                    // set the degree of zoom
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 200, 200)
                    _mapView.setRegion(region, animated: _animated)
                }
                
            }
            
        })
        
        //---

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func ratingButtonTapped(segue : UIStoryboardSegue)
    {
        if let rating = segue.identifier{
            
            self.restaurant.isVisited = true;
            
            switch rating{
                case "great": self.restaurant.rating = "Absolutely love it! Must try."
                
                case "good" : self.restaurant.rating = "Pretty good."
                
                case "dislike" : self.restaurant.rating = "I don't like it."
                
                default: break
            }
        }
        
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! RestaurantDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "phone"
            cell.valueLabel.text = restaurant.phone
        case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = restaurant.isVisited ? "Yes, I've been here before" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "showRestaurantDetail" {
     if let indexPath = tableView.indexPathForSelectedRow {
     let destinationController = segue.destination as! RestaurantDetailViewController
     destinationController.restaurant = restaurants[indexPath.row]
     }
     }
     }

     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview"{
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = self.restaurant
            
        }else if segue.identifier == "showMap"{
            let destinationController = segue.destination as! MapViewController
            destinationController.resturant = self.restaurant
        }
    }
}//class
