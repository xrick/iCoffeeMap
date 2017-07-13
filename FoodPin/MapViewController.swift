//
//  MapViewController.swift
//  FoodPin
//
//  Created by Liao Jiue-Ren on 07/05/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet var mapView : MKMapView!
    var resturant : Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let geoCoder = CLGeocoder.init()
        geoCoder.geocodeAddressString(resturant.location, completionHandler: {
        placemakers, error in
            if error != nil {
                print(error)
                return
            }
            
            if let placemakers = placemakers {
                let placemaker = placemakers[0]
                
                let annotation = MKPointAnnotation.init()
                annotation.title = self.resturant.name
                annotation.subtitle = self.resturant.type
                
                if let location = placemaker.location{
                    annotation.coordinate = location.coordinate
                    
                    //show annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        
        
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        var annotationView : MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(named: resturant.image)
        annotationView?.leftCalloutAccessoryView = leftIconView
        return annotationView
    }
        

}
