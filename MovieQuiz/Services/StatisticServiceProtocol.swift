//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Alibi on 30.05.2024.
//

import Foundation
import UIKit

protocol StatisticServiceProtocol {
    var gamesCount: Int { get set }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
    
    func store(correct count: Int, total amount: Int)
}
