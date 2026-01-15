import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var recipientTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the UI
        messageTextView.layer.borderColor = UIColor.lightGray.cgColor
        messageTextView.layer.borderWidth = 1.0
        messageTextView.layer.cornerRadius = 5.0
    }
    
    @IBAction func sendEmailButtonTapped(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            
            // Set recipients
            if let recipient = recipientTextField.text, !recipient.isEmpty {
                mailComposeViewController.setToRecipients([recipient])
            }
            
            // Set subject
            if let subject = subjectTextField.text, !subject.isEmpty {
                mailComposeViewController.setSubject(subject)
            }
            
            // Set message body
            if let message = messageTextView.text, !message.isEmpty {
                mailComposeViewController.setMessageBody(message, isHTML: false)
            }
            
            present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showAlert(title: "Error", message: "Cannot send email from this device. Please configure an email account in Settings.")
        }
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        var title = ""
        var message = ""
        
        switch result {
        case .cancelled:
            title = "Cancelled"
            message = "Email was cancelled"
        case .saved:
            title = "Saved"
            message = "Email was saved as draft"
        case .sent:
            title = "Sent"
            message = "Email was sent successfully"
        case .failed:
            title = "Failed"
            message = "Email failed to send: \(error?.localizedDescription ?? "Unknown error")"
        @unknown default:
            title = "Unknown"
            message = "An unknown result occurred"
        }
        
        controller.dismiss(animated: true) {
            self.showAlert(title: title, message: message)
        }
    }
    
    // MARK: - Helper Methods
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
