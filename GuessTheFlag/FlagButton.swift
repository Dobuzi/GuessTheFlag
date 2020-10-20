//
//  FlagButton.swift
//  GuessTheFlag
//
//  Created by 김종원 on 2020/10/18.
//

import SwiftUI

struct FlagButton: View {
    var number: Int
    
    @Binding var countries: [String]
    @Binding var gradients: [Gradient]
    @Binding var correctAnswer: Int
    @Binding var tappedNumber: Int
    @Binding var showingScore: Bool
    @Binding var score: Int
    
    var body: some View {
        Button(action: {
            self.flagTapped(number)
        }, label: {
            Image(self.countries[number])
                .renderingMode(.original)
                .flagStyle()
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            self.askQuestion()
        } else {
            showingScore = true
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
