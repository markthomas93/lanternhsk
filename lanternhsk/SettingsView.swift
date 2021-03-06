//
//  SettingsView.swift
//  lanternhsk
//
//  Created by Alexey Smirnov on 4/9/20.
//  Copyright © 2020 Alexey Smirnov. All rights reserved.
//

import SwiftUI
import CoreData

struct SettingsView: View {    
    @ObservedObject var model = SettingsModel()
    @State private var trigger: Bool = false

    var body: some View {
        print("\(trigger)")
        
        let content =
            VStack {
                List {
                    Text("Characters").font(.headline)
                    
                    Picker(selection: $model.language, label: Text("")) {
                        Text("Traditional").tag(SettingsCharType.traditional.rawValue)
                        Text("Simplified").tag(SettingsCharType.simplified.rawValue)
                    }
                    .labelsHidden()
                    .clipped()
                    .frame(height: 100)
                    
                    Text("Questions: \(Int(model.numQuestions))").font(.headline)
                    
                    Slider(value: $model.numQuestions, in: 1...20, step: 1)
                }
            }
            .onReceive(model.settingsChanged, perform: { _ in
                self.trigger.toggle()
            })
        
        #if os(watchOS)
        return content.navigationBarTitle("Options")
        #else
        return content
            .navigationBarTitle("Options", displayMode: .inline)
            .onAppear { UITableView.appearance().separatorStyle = .none }
            .onDisappear { UITableView.appearance().separatorStyle = .singleLine }
        #endif

    }
}

