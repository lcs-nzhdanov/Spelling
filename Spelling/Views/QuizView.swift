//
//  QuizView.swift
//  Spelling
//
//  Created by Russell Gordon on 2023-10-30.
//

import SwiftUI

struct QuizView: View {
    
    // MARK: Stored properties
    @State var currentItem = itemsToSpell.randomElement()!
    
    // The user's guess
    @State var userGuess = ""
    
    // The outcome
    @State var currentOutcome: Outcome = .undetermined
    
    // An array to store results of user's guesses
    @State var history: [Result] = [] // empty array
    
    
    // MARK: Computed properties
    var body: some View {
        
        HStack {
            
            // Left Side
            VStack {
                Image(currentItem.imageName)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    
                    // Allow the user to input their guess
                    TextField("Enter the name of the item", text: $userGuess)
                    
                    // Show outcome (shows the string attached to each case in the enumeration)
                    Text(currentOutcome.rawValue)
                }
                // Make it possible to check the guess made
                
                
                HStack {
                    
                    Button {
                        checkGuess()
                    } label: {
                        Text("Submit")
                    }
                    
                    Button {
                        newWord()
                    } label: {
                        Text("New word")
                    }

                }

            }
            
            // Right Side
            List(history) { currentResult in
                
                HStack {
                    Image(currentResult.item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    
                    Text(currentResult.guessProvided)
                    
                    Spacer()
                    
                    Text(currentResult.outcome.rawValue)
                }
            }
        }
        
        
        
    }
    
    // MARK: Functions
    func checkGuess() {
        
        if userGuess == currentItem.word {
            print("Correct")
            currentOutcome = .correct
        } else {
            print("Incorrect")
            currentOutcome = .incorrect
        }
    }
    
    func newWord() {
        
        // Add the current result to the history
        history.insert(
            Result(
                item: currentItem,
                guessProvided: userGuess,
                outcome: currentOutcome
            ),
            at: 0
        )
        
        // DEBUG: What is in the history array?
        print(history)
        
        currentItem = itemsToSpell.randomElement()!
        userGuess = ""
        currentOutcome = .undetermined
    }
}

#Preview {
    QuizView()
}
