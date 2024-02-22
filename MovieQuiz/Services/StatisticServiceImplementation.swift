import Foundation

class StatisticServiceImplementation: StatisticService {
    
    private let userDefault = UserDefaults.standard
    
    func store(correct count: Int, total amount: Int) {
        let newGame = GameRecord(correct: count, total: amount, date: Date())
        if (newGame.isBetterThan(bestGame)) {
            bestGame = newGame
        }
        correctCount = correctCount + count
        totalCount = totalCount + amount
        gamesCount = gamesCount + 1
    }
    
    private var correctCount: Int {
        get {
            return userDefault.integer(forKey: Keys.correct.rawValue)
        }

        set {
            userDefault.set(newValue, forKey: Keys.correct.rawValue)
        }
    }
    
    
    private var totalCount: Int {
        get {
            return userDefault.integer(forKey: Keys.total.rawValue)
        }

        set {
            userDefault.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        get {
            return Double(correctCount) / Double(totalCount) * 100
        }
    }
    
    var gamesCount: Int {
        get {
            return userDefault.integer(forKey: Keys.gamesCount.rawValue)
        }

        set {
            userDefault.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefault.data(forKey: Keys.bestGame.rawValue),
            let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }

            return record
        }

        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }

            userDefault.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }

}
