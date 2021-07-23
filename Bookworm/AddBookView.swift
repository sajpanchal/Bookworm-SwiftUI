//
//  AddBookView.swift
//  Bookworm
//
//  Created by saj panchal on 2021-07-23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @State var title = ""
    @State var author = ""
    @State var genre = ""
    @State var rating = 3
    @State var review = ""
    let genres = ["Fantasy","Horror","Kids","Mystery","Poetry","Romance","Triller"]
    var body: some View {
        Form {
            Section {
                TextField("Name of book", text:$title)
                TextField("Author's name", text:$author)
                Picker("Genre", selection:$genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
            }
            Section {
                Picker("Rating", selection:$rating) {
                    ForEach(0..<6) {
                        Text("\($0)")
                    }
                }
                TextField("Write a review", text:$review)
            }
            Section {
                Button("Save") {
                    let newBook = Book(context: moc)
                    newBook.title = self.title
                    newBook.author = self.author
                    newBook.rating = Int16(self.rating)
                    newBook.genre = self.genre
                    newBook.review = self.review
                    try? self.moc.save()
                }
            }
        }.navigationBarTitle("Add Book")
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
