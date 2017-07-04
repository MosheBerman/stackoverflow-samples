//
//  ViewController.swift
//  CustomUIAlertController
//
//  Created by Moshe Berman on 7/4/17.
//  Copyright © 2017 Moshe Berman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Presenting UIAlertController
    
    @IBAction func presentAlertController()
    {
        let alertController = self.alertController
        
        /**
         Try styling before or after presentation.
         Try with UIAppearance or subview traversal.
         */
        
        // self.styleAlertControllerWithUIAppearance()
        // self.styleAlertControllerWithSubviewTraversal()
        self.present(alertController, animated: true)
        {

            // self.styleAlertControllerWithUIAppearance()
           self.styleAlertControllerWithSubviewTraversal()
        }
    }

    // MARK: - Setting up UIAlertController
    
    var alertController:UIAlertController
    {
        
        let title = NSLocalizedString("Demo", comment: "A title")
        let message = NSLocalizedString("How far can we push this?", comment: "A message")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
    
        let cameraTitle = NSLocalizedString("Camera", comment: "A title for the camera button")
        let cameraItem: UIAlertAction = UIAlertAction(title: cameraTitle, style: .default, handler: nil)
        
        let cancelTitle = NSLocalizedString("Cancel", comment: "A title for the cancel button")
        let cancelItem = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        
        alertController.addAction(cameraItem)
        alertController.addAction(cancelItem)
        
        return alertController
    }

    
    // MARK: - Styling Alert Controller
    
    
    /// Let's try this?
    func styleAlertControllerWithUIAppearance()
    {
        guard let classFromString = NSClassFromString("_UIAlertControllerActionView") as? UIAppearanceContainer.Type else
        {
            print("Couldn't instantiate the class as UIAppearance.")
            return
        }
        
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.3, alpha: 1.0)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.white
        UILabel.appearance(whenContainedInInstancesOf: [classFromString]).textAlignment = .left
        
    }
    
    func styleAlertControllerWithSubviewTraversal()
    {
        let alertController = self.alertController
        
        guard let view = alertController.view else
        {
            print("Couldn't get alert controller view.")
            return
        }
        
        let labels = self.recursivelyFind(in: view)
        
        for label in labels
        {
            label.textAlignment = .left
            print("Label: \(label)")
        }
    }
    
    // MARK: - Searching for Labels
    
    func recursivelyFind(in view: UIView) -> [UILabel]
    {
        var subviewsOfType: [UILabel] = []
        
        for view in view.subviews
        {
            
            if let label = view as? UILabel
            {
                subviewsOfType.append(label)
            }
            
            for subview in view.subviews
            {
                let recursiveMatches = self.recursivelyFind(in:subview)
                
                subviewsOfType.append(contentsOf: recursiveMatches)
            }
        }
        
        return subviewsOfType
    }
    
    
}

