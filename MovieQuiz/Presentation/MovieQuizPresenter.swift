import Foundation
import UIKit

final class MovieQuizPresenter {
    private var dateFormatter: DateFormatter {
        let d = DateFormatter()
        d.locale = Locale(identifier: "ru_RU")
        d.setLocalizedDateFormatFromTemplate("dd.MM.yy HH:mm")
        return d
    }
    
    var questionFactory: QuestionFactoryProtocol?
    var correctAnswers = 0
    private var statisticService = StatisticService()
    let questionsAmount: Int = 10
    private var currentQuestionIndex = 0
    var currentQuestion: QuizQuestion?
    weak var viewController: MovieQuizViewController?
    
    public func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel( // 1
            image: UIImage(data: model.image) ?? UIImage(), // 2
            question: model.text, // 3
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)") // 4
        return questionStep
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func resetQuestionIndex() {
        currentQuestionIndex = 0
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func yesButtonClicked() {
        didAnswer(isYes: true)
    }
    
    func noButtonClicked() {
        didAnswer(isYes: false)
    }
    
    
    private func didAnswer(isYes: Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = isYes
        
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        // проверка, что вопрос не nil
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    func showNextQuestionOrResults() {
        if isLastQuestion() {
            statisticService.store(correct: correctAnswers, total: questionsAmount)
            
            let formattedDate = dateFormatter.string(from: statisticService.bestGame.date)
            let text = """
            Ваш результат: \(correctAnswers)/\(questionsAmount)
            Количество сыграных квизов: \(statisticService.gamesCount)
            Рекорд: \(statisticService.bestGame.correct)/\(statisticService.bestGame.total)
            (\(formattedDate))
            Средняя точность: \(statisticService.totalAccuracy)%
            """
            
            let viewModel = QuizResultsViewModel( // 2
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            viewController?.show(quiz: viewModel) // 3
        } else {
            switchToNextQuestion()
            questionFactory?.requestNextQuestion()
        }
    }
}
