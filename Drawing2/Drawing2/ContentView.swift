//
//  ContentView.swift
//  Drawing2
//
//  Created by 野中淳 on 2022/12/21.
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

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
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



struct Spirograph:Shape{
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
        
    }
    
    let innerRadius:Int
    let outerRadius:Int
    let distance:Int
    let amount:Double
    
    func gcd(_ a:Int,_ b:Int)-> Int{
        var a = a
        var b = b
        while b != 0{
            let temp = b
            b = a % b
            a = temp
        }
        return a
    }
    
}



struct Checkerboard:Shape{
    
    
    var rows:Int
    var columns:Int
    
    var animatableData: AnimatablePair<Double,Double>{
        get{
            AnimatablePair(Double(rows), Double(columns))
        }
        set{
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect:CGRect)->Path{
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


struct Arc:Shape{
    var startAngle:Double
    var endAngle:Double
    var clockwise:Bool
    
    
    var animatableData: Double{
        get{endAngle}
        set{endAngle = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle(degrees: 90)
        let modifiedStart = Angle(degrees: startAngle) - rotationAdjustment
        let modifiedEnd = Angle(degrees: endAngle) - rotationAdjustment
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockwise)
        
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
}

struct Arrow:Shape{
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x:rect.maxX,y:rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX * 2 / 3, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX * 2 / 3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 1 / 3, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.maxX * 1 / 3, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x:rect.midX,y:rect.minY))
        return path
    }
}

struct ContentView: View {
    @State private var line = 10.0
    @State private var amount = 10.0
    var body: some View {
        VStack{
            ColorCyclingRectangle(amount:amount )
            Slider(value:$amount)
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
