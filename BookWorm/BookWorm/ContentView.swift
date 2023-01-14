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
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books:FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View{
        NavigationView {
            List{
                ForEach(books){ book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack{
                            EmojiRatingView(ratting: book.raiting)
                                .font(.largeTitle)
                            VStack(alignment:.leading){
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                }.onDelete (perform: deleteBooks)
                
            }
            
            .navigationTitle("Bookworm")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book",systemImage: "plus")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }.sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets:IndexSet){
        for offset in offsets{
            
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
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
