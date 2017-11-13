import UIKit

class ViewController: UIViewController {
    
  let allQuestions = QuestionBank()
  var questionNum = 0
  var pickedAnswer = false
  
  var score = 0
  var progress = 1
    
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var progressBar: UIView!
  @IBOutlet weak var progressLabel: UILabel!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    NextQuestion()
  }

  @IBAction func answerPressed(_ sender: AnyObject) {
    if sender.tag == 1 {
      pickedAnswer = true
    } else if sender.tag == 2 {
      pickedAnswer = false
    }
    
    CheckAnswer()
    NextQuestion()
  }
    
  func UpdateUI() {
    questionLabel.text = allQuestions.list[questionNum].questionText
    scoreLabel.text = "Score: " + String(score)
    progressLabel.text = String(progress) + "/\(allQuestions.list.count)"
    
    progressBar.frame.size.width = (view.frame.size.width/13) * CGFloat(questionNum + 1)
  }
  
  func NextQuestion() {
    UpdateUI()
    
    questionNum += 1
    if questionNum == allQuestions.list.count {
      AlertUser()
    }
  }
  
  func CheckAnswer() {
    if pickedAnswer == allQuestions.list[questionNum].answer {
      ProgressHUD.showSuccess("Correct!")
      score += 1
    } else {
      ProgressHUD.showError("Wrong!")
    }
    
    progress += 1
  }
  
  func AlertUser() {
    let alert = UIAlertController(title: "Finish", message: "Want to start over?", preferredStyle: .alert)
    let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
      self.StartOver()
    }
    alert.addAction(restartAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  func StartOver() {
    questionNum = 0
    score = 0
    progress = 0
    NextQuestion()
  }
  
    
}
