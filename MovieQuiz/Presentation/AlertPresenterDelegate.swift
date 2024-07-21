//
//  AlertPresenterDelegate.swift
//  MovieQuiz
//
//  Created by Alibi on 20.05.2024.
//
import UIKit
import Foundation

protocol AlertPresenterDelegate: AnyObject {
    func didLoadAlert(ui: UIAlertController)
}
