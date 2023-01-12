//
//  ContentView.swift
//  BookWorm
//
//  Created by 野中淳 on 2023/01/09.
//

import SwiftUI


struct ContentView: View {
    
    //@FetchRequest(sortDescriptors: []) var students:FetchedResults<Student>
    //書き込みに使う
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books:FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View{
        NavigationView {
            Text("Count: \(books.count)")
                .navigationTitle("Bookworm")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book",systemImage: "plus")
                        }
                        
                    }
                }.sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }
    
}

struct PushButton:View{
    let title:String
    @Binding var isOn:Bool
    
    var onColors = [Color.red,Color.yellow]
    var offColors = [Color(white:0.6),Color(white: 0.4)]
    
    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            Text(title)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors:offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0: 5)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
