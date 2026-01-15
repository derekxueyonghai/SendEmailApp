//
//  ContentView.swift
//  SendEmail
//
//  Created by xuederek  on 15/1/26.
//

import MessageUI
import SwiftUI

struct ContentView: View {
    @State private var showingMailView = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var mailResultID = UUID()

    @State private var recipientEmail = "example@example.com"
    @State private var emailSubject = "Hello from SendEmail App!"
    @State private var emailBody = "This is a test email sent from my awesome iOS app!"

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "envelope.fill")
                    .imageScale(.large)
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)

                Text("Send Email")
                    .font(.title)
                    .fontWeight(.bold)

                Form {
                    Section(header: Text("Email Details")) {
                        TextField("Recipient", text: $recipientEmail)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)

                        TextField("Subject", text: $emailSubject)

                        TextEditor(text: $emailBody)
                            .frame(height: 100)
                    }
                }

                Button(action: {
                    if MFMailComposeViewController.canSendMail() {
                        showingMailView = true
                    } else {
                        alertMessage = "Your device is not configured to send emails. Please set up Mail app first."
                        showingAlert = true
                    }
                }) {
                    HStack {
                        Image(systemName: "paperplane.fill")
                        Text("Send Email")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Email Composer")
            .sheet(isPresented: $showingMailView) {
                MailView(
                    result: $mailResult,
                    resultID: $mailResultID,
                    recipients: [recipientEmail],
                    subject: emailSubject,
                    messageBody: emailBody,
                    isHTML: false
                )
            }
            .alert("Email Status", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
            .onChange(of: mailResultID) {
                if let result = mailResult {
                    switch result {
                    case let .success(mailResult):
                        switch mailResult {
                        case .sent:
                            alertMessage = "Email sent successfully!"
                        case .saved:
                            alertMessage = "Email saved as draft."
                        case .cancelled:
                            alertMessage = "Email cancelled."
                        case .failed:
                            alertMessage = "Failed to send email."
                        @unknown default:
                            alertMessage = "Unknown result."
                        }
                    case let .failure(error):
                        alertMessage = "Error: \(error.localizedDescription)"
                    }
                    showingAlert = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
