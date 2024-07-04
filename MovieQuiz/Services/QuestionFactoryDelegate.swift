//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Alibi on 20.05.2024.
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {               // 1
     func didReceiveNextQuestion(question: QuizQuestion?)    // 
}
