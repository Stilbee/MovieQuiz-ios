import Foundation
import UIKit

class AlertPresenter {
    
    public static func show(alert alertModel: AlertModel, from parent: UIViewController) {
        let alert = UIAlertController(title: alertModel.title, message: alertModel.message, preferredStyle: .alert)
        alert.title = alertModel.title
        alert.message = alertModel.message
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
            alertModel.completion()
        }
        alert.addAction(action)
        parent.present(alert, animated: true)
    }
}
