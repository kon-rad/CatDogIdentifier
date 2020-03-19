//
//  ViewController.swift
//  CatDogIdentifier
//
//  Created by Konrad Gnat on 3/18/20.
//  Copyright © 2020 Konrad Gnat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    private var images: [String] = [String]()
    
    private var currentIndex: Int = 0
    
    let model = CatsAndDogs();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImages()

        if let imageURL = images.first {
            displayImage(imageURL: imageURL)
        }
        print(self.images.isEmpty)
        if self.images.isEmpty {
            if let imageURL = images.first {
                displayImage(imageURL: imageURL)
            }
        }
    }
    
    private func displayImage(imageURL: String) {
        
        let img = UIImage(named: imageURL)
        self.photoImageView.image = img
        
        showPredictions(img)
        
    }
    
    private func showPredictions(_ img: UIImage?) {
        
        guard let img = img,
            let resizedImage = img.resizeTo(size: CGSize(width: 299, height: 299)),
            let pixelBuffer = resizedImage.pixelBuffer()
            else {
                fatalError("Incompatible image")
        }
        
        if let prediciton = try? model.prediction(image: pixelBuffer) {
            self.predictionLabel.text = prediciton.classLabel
        }
    }

    private func loadImages() {
        
        self.images = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "test_images")
        
    }
    
    @IBAction func nextButtonPressed() {
        print(self.images.count)
        print(self.currentIndex)
        
        if self.currentIndex <= self.images.count - 1 {
            displayImage(imageURL: self.images[self.currentIndex])
            self.currentIndex += 1
        } else {
            self.currentIndex = 0
        }
        
    }

}

