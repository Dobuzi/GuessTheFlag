//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 김종원 on 2020/10/17.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var gradients = [
        Gradient(colors: [.green, .accentColor, .white]),
        Gradient(colors: [.red, .accentColor, .white]),
        Gradient(colors: [.purple, .accentColor, .white]),
        Gradient(colors: [.blue, .gray, .white]),
        Gradient(colors: [.orange, .accentColor, .white])
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var tappedNumber = 99
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: gradients[0],
                startPoint: .top,
                endPoint: .bottom
            )
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 5) {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                Spacer()
                VStack(spacing: 80) {
                    ForEach(0 ..< 3) { number in
                        FlagButton(
                            number: number,
                            countries: $countries,
                            gradients: $gradients,
                            correctAnswer: $correctAnswer,
                            tappedNumber: $tappedNumber,
                            score: $score
                            )
                    }
                }
                Spacer()
                HStack {
                    Text("Score : \(score)")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .fontWeight(.heavy)
                    Spacer()
                    Button(action: {
                        self.restartGame()
                        self.askQuestion()
                    }, label: {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Restart")
                        }
                        .font(.headline)
                    })
                }
                .padding(50)
            }
        }
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        gradients = gradients.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
