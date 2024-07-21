//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Alibi on 20.05.2024.
//

import Foundation
struct AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completion: () -> Void
}
