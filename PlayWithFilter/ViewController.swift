//
//  ViewController.swift
//  PlayWithFilter
//
//  Created by Tushar Khandaker on 7/20/22.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = UIImage(named: "sample.jpg", in: Bundle(for: type(of: self)), compatibleWith: nil)
        }
    }
    let filters = ["CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur","CIGaussianBlur"]
    
    var context = CIContext()
    var currentFilter = "CISepiaTone"
    var currentImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        currentImage = UIImage(named: "sample.jpg", in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }
}

extension ViewController {
    
    func applyFilter() {
        let ciImage = CIImage(image: currentImage)
        let filter = CIFilter(name: currentFilter)
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.label.text = filters[indexPath.item]
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        currentFilter = filters[indexPath.item]
    }
    
}
