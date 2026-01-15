//
//  MailView.swift
//  SendEmail
//
//  Created by xuederek on 15/1/26.
//

import MessageUI
import SwiftUI

struct MailView: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentation
  @Binding var result: Result<MFMailComposeResult, Error>?
  @Binding var resultID: UUID

  var recipients: [String]
  var subject: String
  var messageBody: String
  var isHTML: Bool

  class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    @Binding var presentation: PresentationMode
    @Binding var result: Result<MFMailComposeResult, Error>?
    @Binding var resultID: UUID

    init(presentation: Binding<PresentationMode>,
         result: Binding<Result<MFMailComposeResult, Error>?>,
         resultID: Binding<UUID>)
    {
      _presentation = presentation
      _result = result
      _resultID = resultID
    }

    func mailComposeController(_: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?)
    {
      defer {
        $presentation.wrappedValue.dismiss()
      }

      if let error = error {
        self.result = .failure(error)
      } else {
        self.result = .success(result)
      }
      resultID = UUID()
    }
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(presentation: presentation, result: $result, resultID: $resultID)
  }

  func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
    let mailComposer = MFMailComposeViewController()
    mailComposer.mailComposeDelegate = context.coordinator
    mailComposer.setToRecipients(recipients)
    mailComposer.setSubject(subject)
    mailComposer.setMessageBody(messageBody, isHTML: isHTML)
    return mailComposer
  }

  func updateUIViewController(_: MFMailComposeViewController,
                              context _: UIViewControllerRepresentableContext<MailView>) {}
}
