
import UIKit

class FurnitureDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var furniture: Furniture?
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
    init?(coder: NSCoder, furniture: Furniture?) {
        self.furniture = furniture
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        guard let furniture = furniture else {return}
        if let imageData = furniture.imageData,
           let image = UIImage(data: imageData) {
            photoImageView.image = image
        } else {
            photoImageView.image = nil
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
    
    @IBAction func choosePhotoButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let imageAlertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        imageAlertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let chooseCameraAction = UIAlertAction(title: "Take a Photo", style: .default, handler: {action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            imageAlertController.addAction(chooseCameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            imageAlertController.addAction(choosePhotoAction)
        }
        imagePicker.popoverPresentationController?.sourceView = sender
        present(imageAlertController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: updateView)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            furniture?.imageData = selectedImage.jpegData(compressionQuality: 0.9)
            
            
        }
        updateView()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        guard let furniture = furniture else {
            return
        }
        var furnitureItems: [Any] = ["\(furniture.name) \(furniture.description)"]
        if let image = photoImageView.image {
            furnitureItems.append(image)
            
        }
        let activityController = UIActivityViewController(activityItems: furnitureItems, applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
}

