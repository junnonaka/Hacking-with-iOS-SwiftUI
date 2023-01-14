//
//  ContentView.swift
//  Instafilter
//
//  Created by 野中淳 on 2023/01/13.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image:Image?
    
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)

    }
    
    func loadImage(){
        //UIImageとして読み込み
        guard let inputImage = UIImage(named: "Example")else{return}
        //CIImageに変換
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        //let currentFilter = CIFilter.sepiaTone()
        //let currentFilter = CIFilter.pixellate()
        //let currentFilter = CIFilter.crystallize()
        let currentFilter = CIFilter.twirlDistortion()

        //CIFilterにCIImageを入れる
        currentFilter.inputImage = beginImage
        //currentFilter.intensity = 1
        //currentFilter.scale = 100
        //currentFilter.radius = 200
        currentFilter.radius = 1000
        currentFilter.center = CGPoint(x: inputImage.size.width/2, y: inputImage.size.height/2)
        
        //FilterをかけたCIImageを取得
        guard let outputImage = currentFilter.outputImage else {return}
        
        //CIImageからCGImageに変換
        if let cgimag = context.createCGImage(outputImage, from: outputImage.extent){
            
            //cgImageからUIImageに変換
            let uiImage = UIImage(cgImage: cgimag)
            
            //UIImageからSwiftUI Imageに変換
            image = Image(uiImage: uiImage)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
