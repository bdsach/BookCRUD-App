//
//  LoadingView.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .controlSize(.large)
    }
}

#Preview {
    LoadingView()
}
