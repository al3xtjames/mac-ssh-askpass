// SPDX-License-Identifier: 0BSD

import AppKit
import Foundation

func showU2FPrompt(message: String) -> Void {
    let messageParts = message.split(separator: " ")
    if messageParts.count < 7 {
        exit(1)
    }

    let keyType = messageParts[5];
    let keyFingerprint = messageParts[6];

    let alert = NSAlert()
    alert.icon = NSImage(systemSymbolName: "mediastick", accessibilityDescription: nil)
    alert.messageText = "ssh"
    alert.informativeText = """
    ssh is trying to use an \(keyType) key with the following fingerprint:

    \(keyFingerprint)

    Touch your security key to allow this.
    """
    alert.addButton(withTitle: "Cancel")
    alert.window.level = .floating

    if alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn {
        exit(1)
    }
}

if CommandLine.arguments.count < 2 {
    exit(1)
}

let args = CommandLine.arguments
let message = CommandLine.arguments[1]
if let promptMode = ProcessInfo.processInfo.environment["SSH_ASKPASS_PROMPT"] {
    if promptMode == "none" {
        showU2FPrompt(message: message)
    } else if promptMode == "confirm" {
        // TODO: show confirmation dialog
        exit(1)
    }
} else {
    // TODO: show password dialog
    exit(1)
}
