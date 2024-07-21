//
//  MovieQuizPresenterTests.swift
//  MovieQuizTests
//
//  Created by Alibi on 21.07.2024.
//

import Foundation
import XCTest

@testable import MovieQuiz

final class MovieQuizPresenterTests: XCTestCase {
    
    func testPresenterConvertModel() throws {
        let viewControllerMock = MovieQuizViewControllerMock()
        let sut = MovieQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = QuizQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
        let viewModel = sut.convert(model: question)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.question, "Question Text")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
    
    class MovieQuizViewControllerMock: MovieQuizViewControllerProtocol {
        func show(quiz step: MovieQuiz.QuizStepViewModel) {
            
        }
        
        func show(quiz result: MovieQuiz.QuizResultsViewModel) {
            
        }
        
        func highlightImageBorder(isCorrectAnswer: Bool) {
            
        }
        
        func showLoadingIndicator() {
            
        }
        
        func hideLoadingIndicator() {
            
        }
        
        func showNetworkError(message: String) {
            
        }
        
        func buttons(enabled: Bool) {
            
        }
        
        func hideImageBorder() {
            
        }
    }
}
