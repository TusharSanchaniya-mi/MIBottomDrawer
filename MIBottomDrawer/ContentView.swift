//
//  ContentView.swift
//  MIBottomDrawer
//
//  Created by Tushar S on 30/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isDrawerOpen = true
    
    var body: some View {
        VStack {
            VStack {
                Text("Drag bottom drawer...!!")
            }
            
            Button("Open Drawer") {
                withAnimation(.easeInOut) {
                    self.isDrawerOpen.toggle()
                }
            }
            
            MIBottomDrawer {
                VStack(alignment: .center) {
                    Button("Close Drawer") {
                        withAnimation(.easeInOut) {
                            self.isDrawerOpen.toggle()
                        }
                    }
          
                    Divider()
                    Text("As the Roman Empire began to fall apart in the West, the Germanic tribe called the Franks moved in, taking it in 464. In 507, their king Clovis I made it his capital. Charlemagne moved his capital to Aachen in Germany, but Paris continued as an important town and was attacked by the Vikings twice. When Hugh Capet became king of France in 987, he again made Paris his capital. For a long time, the kings only controlled Paris and the surrounding area, as much of the rest of France was in the hands of barons or English. During the Hundred Years' War, the English controlled Paris from 1420 to 1437.")
                    
                }
            }
            .snapPoint(at: .constant(self.isDrawerOpen ? [150, 450, UIScreen.main.bounds.height / 1.25] : [40]))
            .handlerBackground(.black.opacity(0.6))
            .edgesIgnoringSafeArea(.vertical)
        }
    }
}

#Preview {
    ContentView()
}
