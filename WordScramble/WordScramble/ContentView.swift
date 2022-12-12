//
//  ContentView.swift
//  WordScramble
//
//  Created by 野中淳 on 2022/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        //入力を小文字始まりにする
                        .textInputAutocapitalization(.never)
                }
                
                Section{
                    ForEach(userWords,id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }.navigationTitle(rootWord)
            //Enterを押したときに実行
            .onSubmit {
                addNewWord()
            }
            .onAppear {
                startGame()
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {             }
            }message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("reStart") {
                    startGame()
                }
            }

        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {return}
        
        //判断
        
        guard isLessThan3(word: answer) else{
            wordError(title: "Word less than3", message: "less than 3")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word useed already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else{
            wordError(title: "Word not possible", message: "You can't spell that from \(rootWord)")
            return
        }
        
        guard isReal(word: answer) else{
            wordError(title: "Word not recognized", message: "You can't just make them up, you know")
            return
        }
        //アニメーションさせる場合
        withAnimation {
            userWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame(){
        
        //URLの取得
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            
            //ファイルからデータ読み出す
            //このとき一連のStringとして読み出される
            if let startWords = try? String(contentsOf: startWordsURL){
                //改行で配列に分ける
                let allWords = startWords.components(separatedBy: "\n")
                //ランダムな項目を取得
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func isLessThan3(word:String)->Bool{
        return word.count < 3
    }
    
    func isOriginal(word:String)-> Bool{
        return !userWords.contains(word)
    }
    
    func isPossible(word:String)->Bool{
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    func isReal(word:String)->Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title:String,message:String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
