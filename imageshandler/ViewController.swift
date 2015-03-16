//
//  ViewController.swift
//  imageshandler
//
//  Created by Tony on 16/03/2015.
//  Copyright (c) 2015 dobrev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.pickedImage.image = image
        
        let myApiKey:NSString = "YOUR_API_KEY"
        Everlive.setApplicationKey(myApiKey)
        
        var imageName:String = "some image";
        var imageData = UIImagePNGRepresentation(image)
        
        let file:EVFile = EVFile()
        file.filename = imageName
        file.data = imageData
        file.contentType = nil
        
        file.save { (result:Bool, error:NSError!) -> Void in
            if(result) {
                println("Success")
            } else {
                println("Failed to create activity: " + error.domain)
            }
        }
      
        
    }
    
    @IBAction func pickImageAction(sender: UIButton) {
        var image = UIImagePickerController()
        image.delegate = self;
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }

    @IBOutlet var pickedImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

