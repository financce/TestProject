//
//  Observer.swift
//  TestProject
//
//  Created by slava on 04/06/2021.
//

import Foundation
import Combine
import SwiftUI

class Observer: ObservableObject {
    @Published var view: [String] = []
    @Published var data: [ModelAppList] = []
    @Published var url = "https://pryaniky.com/static/json/sample.json"
    
    var getRequest: AnyCancellable?
    var networkService = NetworkService()
    
    
    init() {
        self.getRequest = self.networkService.getRequest(url: URL(string: url) ?? .init(fileURLWithPath: ""))
            .receive(on: DispatchQueue.main)
            .sink { res in
                switch res {
                case .finished:
                    break
                case .failure(let err):
                    print("Error \(err.localizedDescription)")
                }
                
            } receiveValue: {[weak self] data in
                self?.view = data.view
                self?.data = data.data.map{(ModelAppList(name: $0.data.text ?? "Not Name", nameView: $0.name, image: $0.data.url ?? "Not url link", selector: $0.data.selectedID ?? 0, variants: $0.data.variants ?? [Variant]()))}
        }
    }
}
