//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Alibi on 20.05.2024.
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {
     func didReceiveNextQuestion(question: QuizQuestion?)
     func didLoadDataFromServer()
     func didFailToLoadData(with error: Error)
}
