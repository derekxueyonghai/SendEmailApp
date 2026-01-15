# SendEmailApp

iOS app demonstrating sending email in Swift using MFMailComposeViewController

## Features

- Simple and clean UI for composing emails
- Text fields for recipient email address and subject
- Text view for email message body
- Send email using iOS native Mail composer
- Handles mail composition results (sent, saved, cancelled, failed)
- Error handling for devices without email configuration

## Requirements

- iOS 12.2+
- Xcode 10.2+
- Swift 5.0+

## How to Use

1. Open `SendEmailApp.xcodeproj` in Xcode
2. Build and run the project on a simulator or device
3. Fill in the recipient email, subject, and message
4. Tap "Send Email" button
5. The iOS native mail composer will appear
6. Send or cancel the email

## Implementation Details

The app uses `MFMailComposeViewController` from the `MessageUI` framework to present the native iOS email composer interface. This is the standard way to send emails from iOS applications.

### Key Components

- **AppDelegate.swift**: Application entry point
- **ViewController.swift**: Main view controller with email composition logic
- **Main.storyboard**: UI layout with text fields and button
- **LaunchScreen.storyboard**: Launch screen

### Code Highlights

The app demonstrates:
- Using MFMailComposeViewController for email composition
- MFMailComposeViewControllerDelegate protocol implementation
- Handling different mail composition results
- UI setup with constraints in storyboard
- Error handling when email is not configured on device

## Notes

- To test email sending on a simulator, you must configure a mail account in the iOS Settings app
- On a real device, the device must have an email account configured
- The app will show an error if no email account is configured

