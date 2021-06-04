//
//  DataView.swift
//  TestProject
//
//  Created by slava on 04/06/2021.
//

import SwiftUI

struct DataView: View {
    @EnvironmentObject var obs: Observer
    var body: some View {
        NavigationView {
            List {
                ForEach(obs.view, id:\.self) { item in
                    NavigationLink(destination: DetailView(name: item)) {
                        ViewCell(name: item)
                    }
                }
            }
            .navigationBarTitle(Text("TestApp"))
        }
    }
}


