//
//  ContentView.swift
//  GroceryApp_SwiftData
//
//  Created by Bartłomiej Wojsa on 05/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query private var groceryListItems: [GroceryListItem]
    @State var newItemString: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                VStack {
                    TextField("Your fridge is empty", text: $newItemString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit() {
                            addItem()
                        }
                    Button(action: {
                        addItem()
                    }, label: {
                        Text("Add")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 80)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .cornerRadius(30)
                    })
                    List {
                        ForEach(groceryListItems, id: \.id) { element in
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                                if let safeURL = element.photoSources?.large2x {
                                    AsyncImage(url: URL(string: safeURL)) {
                                        $0
                                            .resizable()
                                            .scaledToFill()
                                            .clipped()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .black, .clear]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(width: geometry.size.width, height: geometry.size.width / 6)
                                .blendMode(.multiply) // Optional: Adjust blend mode to your preference
                                
                                Text(element.title)
                                    .foregroundStyle(Color.gray)
                                    .fontWeight(.semibold)
                                NavigationLink("") {
                                    VStack {
                                        Text(element.title)
                                            .font(.largeTitle)
                                        Text(element.subtitle)
                                            .font(.subheadline)
                                        Text("added: \(calculateDateStr(date: element.date))")
                                    }
                                }
                            }
                            .listRowInsets(EdgeInsets(top: 0, leading: 100, bottom: 10, trailing: 100))
                            .frame(width: geometry.size.width, height: geometry.size.width/2)

                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                withAnimation {
                                    context.delete(groceryListItems[index])
                                }
                                
                            }
                        }
                    }
                    .overlay {
                        if groceryListItems.isEmpty {
                            Text("No items")
                        }
                    }
                    .padding(EdgeInsets())
                    .navigationBarItems(trailing: Button {
                        withAnimation {
                            removeAll()
                        }
                        
                    } label: {
                        Image(systemName: "trash")
                    })

                }
                .navigationTitle("Grocery list")
                
            }
        }
    }
    
    private func calculateDateStr(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    private func removeAll() {
        groceryListItems.forEach { element in
            context.delete(element)
        }
    }
    private func addItem() {
        guard !self.newItemString.isEmpty else {
            return
        }
        PhotoManager.getPhotoByName(self.newItemString) { result in
            var photoSources: PhotoSources? = nil
            if let safeURLs = result?.photos.first?.src {
                photoSources = safeURLs
            }
            let newItem = GroceryListItem(title: self.newItemString, subtitle: "Your fridge need this!", date: Date(), photoSources: photoSources)
            context.insert(newItem)
            self.newItemString = ""
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GroceryListItem.self, inMemory: true)
}
