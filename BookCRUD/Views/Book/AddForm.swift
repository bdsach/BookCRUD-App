//
//  AddForm.swift
//  BookCRUD
//
//  Created by Bandit Silachai on 1/1/24.
//

import SwiftUI

struct AddForm: View {
    
    @Binding var bookName: String
    @Binding var bookAuthor: String
    @Binding var bookPrice: String
    @Binding var disableForm: Bool
    
    var onSave: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Detail of Book") {
                    TextField("Name", text: $bookName)
                    TextField("Author", text: $bookAuthor)
                    TextField("Price", text: $bookPrice)
                        .keyboardType(.numberPad)
                    Button("Save", systemImage: "paperplane.fill") {
                        onSave()
                    }
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .disabled(disableForm)
            }
            .navigationTitle(Text("Add Book"))
            .overlay {
                if disableForm {
                    Rectangle()
                        .fill(.white.opacity(0.3))
                        .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .overlay {
                            ProgressView()
                        }
                }
            }
        }
    }
}
 
