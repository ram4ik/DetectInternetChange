//
//  ContentView.swift
//  DetectInternetChange
//
//  Created by Ramill Ibragimov on 21.06.2020.
//  Copyright © 2020 Ramill Ibragimov. All rights reserved.
//

import SwiftUI
import Network

struct ContentView: View {
    @State private var networkDetected = true
    
    var body: some View {
        VStack {
            ZStack {
                Color(self.networkDetected ? .green : .red)
                    .edgesIgnoringSafeArea(.all)
                Text(self.networkDetected ? "Internet connected" : "Internet not connected")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }.onAppear() {
            self.monitorNetwork()
        }
    }
    
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.networkDetected = true
            } else {
                self.networkDetected = false
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
