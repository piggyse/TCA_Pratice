//
//  ContentView.swift
//  TCA_ImageList
//
//  Created by Gucci on 12/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var id = UUID()
    
    var body: some View {
        VStack {
            ImageListView()
                .id(id)
            
            Spacer()
            HStack {
                Button {
                    id = UUID()
                } label: {
                    Text("새로고침")
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
