//
//  FlagButton.swift
//  GuessTheFlag
//
//  Created by 김종원 on 2020/10/18.
//

import SwiftUI

struct FlagButton: View {
    var number: Int
    
    @State private var rotationAngle: Double = 0
    @State private var isWrong: Bool = false
    
    @Binding var countries: [String]
    @Binding var gradients: [Gradient]
    @Binding var correctAnswer: Int
    @Binding var tappedNumber: Int
    @Binding var score: Int
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.flagTapped(number)
            }
        }, label: {
            ZStack {
                Image(self.countries[number])
                    .renderingMode(.original)
                    .flagStyle()
                Text(isWrong ? self.countries[number] : "")
                    .frame(width:200, height: 100)
                    .background(isWrong ? Color.black.opacity(0.75) : nil)
                    .font(.title)
                    .foregroundColor(.white)
                    .flagStyle()
            }
            
        })
        .rotation3DEffect(
            .degrees(rotationAngle),
            axis: (x: 0.0, y: 1.0, z: 0.0))
        .onChange(of: countries, perform: { _ in
            withAnimation {
                isWrong = false
                tappedNumber = 99
            }
        })    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            rotationAngle += 360
            score += 1
            self.askQuestion()
        } else if !isWrong {
            isWrong = true
            tappedNumber = number
            score -= 1
        }
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        gradients = gradients.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width:200, height: 100)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

extension View {
    func flagStyle() -> some View {
        self.modifier(FlagButtonStyle())
    }
}
