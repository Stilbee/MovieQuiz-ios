import UIKit

final class MovieQuizViewController: UIViewController {
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false)
        
    ]
    

    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion(questions[currentQuestionIndex])
    }
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        showAnswerResult(isCorrect: questions[currentQuestionIndex].correctAnswer == false)
    }
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        showAnswerResult(isCorrect: questions[currentQuestionIndex].correctAnswer == true)

    }
    private func showNextQuestion() {
        imageView.layer.borderWidth = 0
        if currentQuestionIndex == questions.count - 1 {
            showQuizResult()
        } else { 
            currentQuestionIndex += 1
            showQuestion(questions[currentQuestionIndex])
        }
    }
    
    private func showQuestion(_ question: QuizQuestion) {
        imageView.image = UIImage(named: question.image)
        textLabel.text = question.text
        counterLabel.text = "\(currentQuestionIndex + 1)/\(questions.count)"
    }

    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
                correctAnswers += 1
            }
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestion()
        }
    }
    
    private func showQuizResult() {
      
        let alert = UIAlertController(title: "Раунд окончен",
                                      message: "Ваш результат \(correctAnswers) из \(questions.count)",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Сыграть еще раз", style: .default) { _ in
            self.restartGame()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func restartGame() {
        currentQuestionIndex = 0
        correctAnswers = 0
        showQuestion(questions[currentQuestionIndex])
    }
}

