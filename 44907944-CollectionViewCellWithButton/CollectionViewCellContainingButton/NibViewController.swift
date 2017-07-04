//
//  NibViewController.swift
//  CollectionViewCellContainingButton
//
//  Created by Moshe Berman on 7/4/17.
//  Copyright © 2017 Moshe Berman. All rights reserved.
//

import UIKit

class NibViewController: UIViewController {

    @IBOutlet weak var lastTappedLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCollectionViewCell()
        
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

    // MARK: - Setting Up The Collection View Cell
    
    func registerCollectionViewCell()
    {
        guard let collectionView = self.collectionView else
        {
            print("We don't have a reference to the collection view.")
            return
        }
        
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: Bundle.main) 
        
        collectionView.register(nib, forCellWithReuseIdentifier: "com.mosheberman.sample.cell")
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "com.mosheberman.samples.cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.updateButton.addTarget(self, action: #selector(updateLabel(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Updating the Label
    
    @objc func updateLabel(_ sender:Any?)
    {
        guard let button = sender as? UIButton else
        {
            print("Sender isn't a button. Returning.")
            return
        }
        
        guard let contentView = button.superview else
        {
            print("Button isn't inside a contentView. Returning.")
            return
        }
        
        guard let cell = contentView.superview as? UICollectionViewCell else
        {
            print("View's superview isn't a UICollectionViewCell instance. Returning.")
            return
        }
        
        guard let collectionView = self.collectionView else
        {
            print("Our collection view isn't wired up. Returning.")
            return
        }
        
        guard let indexPathForCell = collectionView.indexPath(for: cell) else
        {
            print("The cell doesn't correspond to an index path. Maybe it's not a child of this collection view?")
            return
        }
        
        self.lastTappedLabel.text = "Tapped button at \(indexPathForCell.item), \(indexPathForCell.section)"
    }
}
