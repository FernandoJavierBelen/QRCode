//
//  ViewController.swift
//  QRCode
//
//  Created by Fernando Belen on 23/07/2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var dataField: UITextField!
    @IBOutlet var codeSelector: UISegmentedControl!
    @IBOutlet var displayCodeView: UIImageView!
    
    var filter: CIFilter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Generator"
        
    }

    @IBAction func generatePressed(_ sender: UIButton) {
        
        
        if dataField.text != "" {
            if let text = dataField.text {
                
                let data = text.data(using: .ascii, allowLossyConversion: false)
                
                if codeSelector.selectedSegmentIndex == 0 {
                    filter = CIFilter(name: "CICode128BarcodeGenerator")
                    
                }else {
                    filter = CIFilter(name: "CIQRCodeGenerator")
                }
                
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 10, y: 10)
                let image = UIImage(ciImage: filter.outputImage!.transformed(by: transform))
                displayCodeView.image = image
           
            }
        }else {
            
            let alert = UIAlertController(title: "Alert", message: "empty field", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    

    @IBAction func saveImage(_ sender: UIButton) {
        
        let imageData = displayCodeView.image!.pngData()
        let compresedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    

    
}

