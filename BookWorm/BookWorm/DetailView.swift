//
//  DetailView.swift
//  BookWorm
//
//  Created by 野中淳 on 2023/01/12.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book:Book
    
    var body: some View {
        ScrollView{
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)

            Text(book.review ?? "No review")
                .padding()

            RatingView(rating: .constant(Int(book.raiting)))
                .font(.largeTitle)
            
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x:-5,y: -5)
            }
        }.navigationTitle(book.title ?? "Unknown Book")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Delete book", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive, action: deleteBook)
                Button("Cancel",role: .cancel) {}
            } message: {
                Text("Are you sure?")
            }
            .toolbar {
                Button {
                    showingDeleteAlert = true
                } label: {
                    Label("Delete this book",systemImage: "trash")
                }

            }

    }
    
    func deleteBook(){
        moc.delete(book)
        
        dismiss()
    }
    
}

struct DetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.raiting = 4
        book.review = "Great book"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
