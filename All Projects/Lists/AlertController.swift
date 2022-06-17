import Foundation
import SwiftUI

extension View {
    func showAlert(title: String, message: String, itemPlaceHolderText: String, importanceLevelPlacholderText: String, okbuttonTitle: String, cancelButtonTitle: String, primaryAction: @escaping (String) -> (), itemImortanceAction: @escaping (String) -> (),  secondaryAction: @escaping ()->()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = itemPlaceHolderText
        }
        
        alert.addTextField { field in
            field.placeholder = importanceLevelPlacholderText
            field.keyboardType = .numberPad
        }
        
        alert.addAction(.init(title: okbuttonTitle, style: .default, handler: { action in
            if let itemNameText = alert.textFields?[0].text {
                primaryAction(itemNameText)
            }
            if let itemImportanceText = alert.textFields?[1].text {
                itemImortanceAction(itemImportanceText)
            }
            
        }))
        
        alert.addAction(.init(title: cancelButtonTitle, style: .cancel, handler: { action in
            secondaryAction()
        }))
        
        rootController().present(alert, animated: true, completion: nil)
    }
    
    func rootController()-> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}

