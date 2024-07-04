//
//  Alertpresenter.swift
//  MovieQuiz
//
//  Created by Alibi on 20.05.2024.
//

import UIKit
import Foundation

class AlertPresenter: AlertPresenterProtocol {
    
    weak var delegate: AlertPresenterDelegate?

    init(delegate: AlertPresenterDelegate) {
        self.delegate = delegate
    }
    
    func showAlert(alert: AlertModel) {
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: alert.buttonText, style: .default) { _ in alert.completion()}
        
        alertController.addAction(action)
        
        delegate?.didLoadAlert(ui: alertController)
        
    }
    
    
}
