//
//  DetailView.swift
//  TestProject
//
//  Created by slava on 04/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    var name: String
    @EnvironmentObject var obs: Observer
    @State private var model = ModelAppList(name: "", nameView: "", image: "", selector: 0, variants: [Variant]())
    @State private var chooise = 0
    
    var body: some View {
        Form{
            Section{
                Text("Id: \(model.id)")
                    .font(.headline)
                Text("Name: \(model.name)")
                    .font(.headline)
                AnimatedImage(url: URL(string: model.image))
                    .resizable()
                    .frame(width: 50, height: 50)
                Picker("Choise", selection: $chooise) {
                    ForEach(0 ..< model.variants.count) {
                        Text("\(self.model.variants[$0].text)")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
        .onAppear{
            model = obs.data.filter{$0.nameView == name}.first ?? .init(name: "", nameView: "", image: "", selector: 0, variants: [Variant]())
            self.chooise = obs.data.filter{$0.nameView == name}.first?.selector ?? 0
        }
    }
}


