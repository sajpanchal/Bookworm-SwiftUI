//
//  AddBookView.swift
//  Bookworm
//
//  Created by saj panchal on 2021-07-23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var author = ""
    @State var genre = ""
    @State var rating = 3
    @State var review = ""
    var date: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date)
        return str
    }
    let genres = ["Fantasy","Horror","Kids","Mystery","Poetry","Romance","Triller"]
    var body: some View {
        Form {
            Section {
                TextField("Name of book", text:$title)
                TextField("Author's name", text:$author)
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(WheelPickerStyle())
            }
            Section {
                RatingView(rating: $rating)
                TextField("Write a review", text:$review)
            }
            Section {
                Button("Save") {
                    let newBook = Book(context: moc)
                    newBook.title = self.title
                    newBook.author = self.author
                    newBook.rating = Int16(self.rating)
                    newBook.genre = self.genre.count > 0 ? self.genre : "N/A"
                    newBook.review = self.review
                    newBook.date = self.date
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
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
