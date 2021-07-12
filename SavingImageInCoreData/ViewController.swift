//
//  ViewController.swift
//  SavingImageInCoreData
//
//  Created by Minju Lee on 2021/07/12.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var saveImageView: UIImageView!
    @IBOutlet weak var fetchImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraButtonTapped))
    }
    
    @objc func cameraButtonTapped(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        saveImageView.image = userPickedImage
        picker.dismiss(animated: true)
    }

    @IBAction func saveImageButtonTapped(_ sender: UIButton) {
        if let imageData = saveImageView.image?.pngData() {
            DataBaseHelper.sharedInstance.saveImage(data: imageData)
        }
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? "Not Found")
    }
    
    @IBAction func fetchImageButtonTapped(_ sender: UIButton) {
        let imageArray = DataBaseHelper.sharedInstance.fetchImage()
        fetchImageView.image = UIImage(data: imageArray[0].img!)
    }
}
