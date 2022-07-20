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
    var currentSliderValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        currentImage = UIImage(named: "sample.jpg", in: Bundle(for: type(of: self)), compatibleWith: nil)!
    }
    
    @IBAction func didChangedSlideValue(_ sender: UISlider) {
        currentSliderValue = Double(sender.value)
        applyFilter()
    }
    
    @IBAction func didTappedOnImportButton(_ sender: UIButton) {
    }
    
    @IBAction func didTappedOnSaveButton(_ sender: UIButton) {
    }
    
    
}

extension ViewController {
    
    func applyFilter() {
        let ciImage = CIImage(image: currentImage)
        guard let filter = CIFilter(name: currentFilter) else { return }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        
        let inputKeys = filter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { filter.setValue(currentSliderValue, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { filter.setValue(currentSliderValue * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { filter.setValue(currentSliderValue * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputCenterKey) { filter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }
        
        if let cgimg = context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
            
        }
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
        if currentFilter == filters[indexPath.item] {
            return
        }
        currentFilter = filters[indexPath.item]
        applyFilter()
    }
}
