//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Liao Jiue-Ren on 04/05/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    //(253,-13)
    @IBOutlet var backgroundImageView : UIImageView!
    @IBOutlet var restaurantView : UIImageView!
    @IBOutlet var containerView : UIView!
    @IBOutlet var closeBtn : UIButton!
    var restaurant: CoffeeShopMO!//Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restaurant = self.restaurant{
            restaurantView.image = UIImage(data: restaurant.image as! Data)
        }
        
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //transform
          //zoom effect
         //containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        
         //slip down
         containerView.transform = CGAffineTransform(translationX: 0, y: -1000)
        
        //Combine two transform
//        let scaleTransform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
//        
//        let translateTransform = CGAffineTransform.init(scaleX: 0, y: -1000)
//        
//        let combineTransform = scaleTransform.concatenating(translateTransform)
        
          //containerView.transform = combineTransform
        
        closeBtn.transform = CGAffineTransform.init(translationX: -1000, y: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.2, animations: {self.containerView.transform = CGAffineTransform.identity})
        
        UIView.animate(withDuration: 0.7, delay: 0.7, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.closeBtn.transform = CGAffineTransform.identity
        }, completion: nil)
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

}
