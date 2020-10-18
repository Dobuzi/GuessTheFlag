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
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var tappedNumber = 0
    @State private var showingScore = false
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .white]),
                startPoint: .top,
                endPoint: .bottom
            )
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                Spacer()
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }, label: {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    })
                }
                Spacer()
                Spacer()
                Spacer()
                HStack {
                    Text("My Score : \(score)")
                        .font(.title2)
                        .foregroundColor(.accentColor)
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
        .alert(isPresented: $showingScore) {
            Alert(
                title: Text("Wrong"),
                message: Text("That's the flag of \(self.countries[tappedNumber])"),
                dismissButton: .default(Text("Continue"))
             {
                self.askQuestion()
            })
        }
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
