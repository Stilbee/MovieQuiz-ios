import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate, AlertPresenterDelegate {
    
    private let presenter = MovieQuizPresenter()
    private var questionFactory: QuestionFactoryProtocol?
    private var correctAnswers = 0
    private var alertPresenter: AlertPresenterProtocol?
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)

        presenter.viewController = self
        presenter.questionFactory = questionFactory
        
        imageView.layer.cornerRadius = 20
        
        alertPresenter = AlertPresenter(delegate: self)
        
        showLoadingIndicator()
        questionFactory?.loadData()
    }
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        presenter.didReceiveNextQuestion(question: question)
    }
    
    @IBAction func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
    @IBAction func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func showAnswerResult(isCorrect: Bool) {
        if isCorrect { // 1
            correctAnswers += 1
        }
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        yesButton.isEnabled = false
        noButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.presenter.correctAnswers = self.correctAnswers
            self.presenter.showNextQuestionOrResults()
            
            yesButton.isEnabled = true
            noButton.isEnabled = true
            imageView.layer.borderWidth = 0
        }
    }
    
    func show(quiz result: QuizResultsViewModel) {
        let alertModel = AlertModel(title: result.title, message: result.text, buttonText: result.buttonText, completion: {[weak self] in guard let self = self else {return}
            self.presenter.resetQuestionIndex()
            self.correctAnswers = 0
            imageView.layer.borderWidth = 0
            questionFactory?.requestNextQuestion()}
        )
        alertPresenter?.showAlert(alert: alertModel)
    }
    
    func didLoadAlert(ui: UIAlertController) {
        self.present(ui, animated: true, completion: nil)
    }
    
    private func showLoadingIndicator() {
        activityIndicator.isHidden = false // говорим, что индикатор загрузки не скрыт
        activityIndicator.startAnimating() // включаем анимацию
    }
    
    private func showNetworkError(message: String) {
        hideLoadingIndicator() // скрываем индикатор загрузки
        
        // создайте и покажите алерт
        let model = AlertModel(title: "Ошибка",
                            message: message,
                            buttonText: "Попробовать еще раз") { [weak self] in
            guard let self = self else { return }
            
            self.presenter.resetQuestionIndex()
            self.correctAnswers = 0
            
            self.questionFactory?.requestNextQuestion()
        }
        alertPresenter?.showAlert(alert: model)
    }
    
    private func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func didLoadDataFromServer() {
        activityIndicator.isHidden = true // скрываем индикатор загрузки
        questionFactory?.requestNextQuestion()
    }

    func didFailToLoadData(with error: Error) {
        showNetworkError(message: error.localizedDescription)
    }
}
