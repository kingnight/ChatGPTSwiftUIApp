//
//  ContentView.swift
//  ChatGPTInn
//
//  Created by kai jin on 2023/2/15.
//

import SwiftUI

enum ItemType {
    case question
    case answer
}

struct Item: Identifiable {
    let id = UUID()
    var text:String = ""
    var type:ItemType
}

class ViewModel: ObservableObject {
    @Published var items = [Item]()
}

#if canImport(UIKit)
extension View{
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView: View {
    @State private var textFieldData = ""
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                List(viewModel.items) { item in
                    if item.type == .question{
                        HStack{
                            Image(systemName: "person.circle.fill")
                            Text(item.text)
                            Spacer()
                        }
                        .font(.title)
                        .padding([.top,.bottom])
                    }
                    else{
                        HStack{
                            Spacer()
                            Text(item.text)
                            Image(systemName: "person.circle.fill")
                        }
                        .padding([.top,.bottom])
                    }
                   
                }
                .listStyle(.plain)
                HStack{
                    TextField("输入你的问题", text: $textFieldData)
                        .textFieldStyle(.roundedBorder)
                    Button("确定", action:{
                        self.hideKeyboard()
                        viewModel.items.append(Item(text: textFieldData,type: .question))
                        textFieldData = ""
                        ChatAPI.shared.sendRequest(param: textFieldData) { result in
                            viewModel.items.append(Item(text: result,type: .answer))
                        }
                    })
                    .buttonStyle(.bordered)
                    
                }.backgroundStyle(.background)
                
            }.navigationTitle("ChatGPT")
            .padding()
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
