//
//  QRCodeScannerExampleView.swift
//  PocketQR
//
//  Created by Collin Maillet on 2025-05-23.
//

import SwiftUI

struct QRCodeScannerExampleView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?

    var body: some View {
        VStack(spacing: 10) {
            if let code = scannedCode {
                NavigationLink("Next page", destination: NextView(scannedCode: code), isActive: .constant(true)).hidden()
            }

            Button("Scan Code") {
                isPresentingScanner = true
            }

            Text("Scan a QR code to begin")
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr]) { response in
                if case let .success(result) = response {
                    scannedCode = result.string
                    isPresentingScanner = false
                }
            }
        }
    }
}
