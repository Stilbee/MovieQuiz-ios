//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Alibi on 30.05.2024.
//

import Foundation

final class StatisticService: StatisticServiceProtocol {
    var storage = UserDefaults.standard
    
    var gamesCount: Int {
        get {
            return storage.integer(forKey: Keys.gamesCount.rawValue)
        }
            
        set {
            storage.setValue(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var correctCount: Int {
        get {
            return storage.integer(forKey: Keys.correct.rawValue)
        }
            
        set {
            storage.setValue(newValue, forKey: Keys.correct.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let total = storage.integer(forKey: Keys.bestGameTotal.rawValue)
            let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
            let correct = storage.integer(forKey: Keys.bestGameCorrect.rawValue)
            
            return GameResult(correct: correct, total: total, date: date)
        }
            
        set {
            storage.setValue(newValue.correct, forKey: Keys.bestGameCorrect.rawValue)
            storage.setValue(newValue.total, forKey: Keys.bestGameTotal.rawValue)
            storage.setValue(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        return round(Double(correctCount) / Double(gamesCount) * 10)
    }
    
    func store(correct count: Int, total: Int) {
        gamesCount += 1
        correctCount += count
        
        
        let gameResult = GameResult(correct: count, total: total, date: Date())
        if (bestGame.correct < gameResult.correct) {
            bestGame = gameResult
        }
    }
}

private enum Keys: String {
    case correct
    case bestGame
    case gamesCount
    case bestGameTotal
    case bestGameCorrect
    case bestGameDate
}
