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
        self.dismissViewControllerAnimated(true, completion: nil)

        self.pickedImage.image = image
        
        let myApiKey:NSString = "YOUR_API_KEY"
        Everlive.setApplicationKey(myApiKey)
        
        var imageName:String = "myImage";
        var imageData = UIImagePNGRepresentation(image)
        
        let file:EVFile = EVFile()
        file.filename = imageName
        file.data = imageData
        file.contentType = nil // TODO - check in the SDK why is this not set behind the scenes
        
        file.save { (result:Bool, error:NSError!) -> Void in
            if(result) {
                println("Success")
            } else {
                println("Failed to upload image: " + error.domain)
            }
        }
      
        // fetch files by filename
        EVFile.fileWithName(imageName, block: { (result:Array!, error:NSError!) -> Void in
            if(error == nil) {
                
                var file:EVFile = result[0] as EVFile;
                println("Success file name")
                self.pickedImage.image = UIImage(data: file.data);
            }
        })
        
        // retrieve an image by Id
        var fileId:NSString = "file id here";
        EVFile.file(fileId) { (file:EVFile!, error:NSError!) -> Void in
            if(error == nil) {
                println("Success file id")
                self.pickedImage.image = UIImage(data: file.data);
            }
        }
        
        // TODO: retrieve an image by Url using the downloadData
        
    }
    @IBAction func pickImageAction(sender: UIButton) {
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        imagePickerController.allowsEditing = false
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
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

