//
//  ScannedCodesListView.swift
//  PocketQR
//
//  Created by Collin Maillet on 2025-05-23.
//This was written with the help of chat gbt here is the conversation link below
// https://chatgpt.com/share/6834bcd5-cb5c-8008-b7ab-0ddc54671e65

import CodeScanner
import SwiftUI

struct ScannedCodesListView: View {
    
    // Your view model (auto-saves & loads)
    @State var viewModel = ScannedCodesListViewModel()
    
    // Scanner sheet toggle
    @State private var isPresentingScanner = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                // Show placeholder if empty, otherwise show list
                if viewModel.scannedCodes.isEmpty {
                    ContentUnavailableView(
                        "Nothing scanned yet",
                        systemImage: "questionmark",
                        description: Text("Please scan a code to get started")
                    )
                } else {
                    List(viewModel.scannedCodes) { currentCode in
                        NavigationLink {
                            QRCodeView(providedString: currentCode.scanedData)
                        } label: {
                            Text(currentCode.scanedData)
                        }
                    }
                    .listStyle(.plain)
                }

                // Always show these controls
                Button("Scan Code") {
                    isPresentingScanner = true
                }
                .buttonStyle(.borderedProminent)

                Text("Scan a QR code to begin")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .padding()
            .navigationTitle("Pocket QR")
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.qr]) { response in
                    if case let .success(result) = response {
                        isPresentingScanner = false
                        viewModel.add(newCode: Code(scanedData: result.string))
                    }
                }
            }
        }
    }
}

struct ScannedCodesListView_Previews: PreviewProvider {
    static var previews: some View {
        ScannedCodesListView()
    }
}

