# SendEmailApp - Technical Documentation

## Overview

This is a demonstration iOS application that shows how to send emails programmatically using Swift and the MessageUI framework.

## Architecture

### Files and Structure

```
SendEmailApp/
├── SendEmailApp/
│   ├── AppDelegate.swift          # Application lifecycle management
│   ├── ViewController.swift       # Main UI and email sending logic
│   ├── Base.lproj/
│   │   ├── Main.storyboard       # Main UI layout
│   │   └── LaunchScreen.storyboard # Launch screen
│   ├── Assets.xcassets/          # App icons and images
│   ├── Info.plist                # App configuration
└── SendEmailApp.xcodeproj/       # Xcode project file
```

## Key Features Implementation

### 1. Email Composition UI

The UI is built using Interface Builder (Main.storyboard) with:
- Title label: "Send Email"
- Recipient text field: For entering email address
- Subject text field: For email subject
- Message text view: For email body
- Send button: Triggers email composition

### 2. Email Sending Logic

The app uses `MFMailComposeViewController` from the MessageUI framework:

```swift
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    // ...
}
```

#### Checking Email Availability

Before presenting the mail composer, the app checks if the device can send email:

```swift
if MFMailComposeViewController.canSendMail() {
    // Present mail composer
} else {
    // Show error message
}
```

#### Setting Up Mail Composer

The mail composer is configured with recipient, subject, and message body:

```swift
let mailComposeViewController = MFMailComposeViewController()
mailComposeViewController.mailComposeDelegate = self
mailComposeViewController.setToRecipients([recipient])
mailComposeViewController.setSubject(subject)
mailComposeViewController.setMessageBody(message, isHTML: false)
```

#### Handling Results

The delegate method handles different email composition results:

```swift
func mailComposeController(_ controller: MFMailComposeViewController, 
                          didFinishWith result: MFMailComposeResult, 
                          error: Error?) {
    switch result {
        case .cancelled: // User cancelled
        case .saved:     // Saved as draft
        case .sent:      // Email sent
        case .failed:    // Failed to send
    }
}
```

## Usage Instructions

### Building the App

1. Open `SendEmailApp.xcodeproj` in Xcode
2. Select a target device or simulator (iOS 12.2+)
3. Press Cmd+R to build and run

### Testing Email Functionality

#### On Simulator:
1. Open the Settings app
2. Navigate to Mail
3. Add an email account (iCloud, Gmail, etc.)
4. Return to SendEmailApp
5. Fill in the email details and tap Send

#### On Device:
- Device must have at least one email account configured in Settings
- The app will use the device's default mail account

### Expected Behavior

1. **Launch**: App displays the email composition form
2. **Fill Form**: Enter recipient email, subject, and message
3. **Tap Send**: Native iOS mail composer appears
4. **Send/Cancel**: Choose to send, save as draft, or cancel
5. **Result**: Alert shows the outcome of the action

## Code Highlights

### MFMailComposeViewControllerDelegate

Required delegate method to handle mail composition completion:

```swift
func mailComposeController(_ controller: MFMailComposeViewController, 
                          didFinishWith result: MFMailComposeResult, 
                          error: Error?)
```

### Error Handling

The app handles two main error scenarios:

1. **No mail account configured**: Shows alert with instructions
2. **Mail sending failed**: Displays error message with details

### UI Customization

The message text view has custom styling applied programmatically:

```swift
messageTextView.layer.borderColor = UIColor.lightGray.cgColor
messageTextView.layer.borderWidth = 1.0
messageTextView.layer.cornerRadius = 5.0
```

## Requirements

- **iOS Version**: 12.2 or later
- **Xcode Version**: 10.2 or later
- **Swift Version**: 5.0 or later
- **Framework**: MessageUI (included in iOS SDK)

## Limitations

- Requires a configured email account on the device
- Cannot send email in the background
- Cannot customize the mail composer UI (it's a system interface)
- Email must be sent through the device's mail accounts (cannot use SMTP directly)

## Future Enhancements

Possible improvements for learning purposes:

1. Add support for attachments
2. Support for multiple recipients (To, CC, BCC)
3. HTML email composition
4. Email templates
5. Form validation
6. Email history/log

## References

- [MFMailComposeViewController Documentation](https://developer.apple.com/documentation/messageui/mfmailcomposeviewcontroller)
- [MessageUI Framework](https://developer.apple.com/documentation/messageui)
- [Swift Programming Language](https://swift.org)
