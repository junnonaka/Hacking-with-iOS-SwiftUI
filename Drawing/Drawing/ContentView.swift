//
//  ContentView.swift
//  Drawing
//
//  Created by 野中淳 on 2022/12/16.
//

import SwiftUI


struct Flower:Shape{    
    
    var petalOffset:Double = -20
    var petalWidth:Double = 100
    func path(in rect:CGRect) -> Path{
        
        var path = Path()
        
        for number in stride(from: 0, through: Double.pi * 2, by: Double.pi/8){
            
            let rotation = CGAffineTransform(rotationAngle: number)
            
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        return path
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Trapezoid: Shape {
    var insetAmount: Double
    //アニメーション化するデータを指定:Animatableを継承しているのでこれを指定するとinsetAmountがアニメーション化する
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
   }
}
    
struct Checkerbord:Shape{
    var rows:Int
    var columns:Int
    func path(in rect:CGRect)->{
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows{
            for column in 0..<columns{
                if (row + column).isMultiple(of: 2){
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}
    
    

struct ContentView: View {
    @State private var insetAmount = 50.0
    
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation{
                    insetAmount = Double.random(in: 10...90)
                    print(insetAmount)
                }
            }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
