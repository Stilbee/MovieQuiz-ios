//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Alibi on 21.07.2024.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
    
    func disableButtons()
    func enableButtons()
    func hideImageBorder()
}
