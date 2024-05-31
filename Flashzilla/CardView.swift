//
//  CardView.swift
//  Flashzilla
//
//  Created by user256510 on 5/7/24.
//

import SwiftUI

extension Shape {
    func cardFill(_ value: CGFloat) -> some View {
        if value == 0 {
            return self.fill(.white)
        } else if value > 0 {
            return self.fill(.green)
        } else {
            return self.fill(.red)
        }
    }
}
struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offSet = CGSize.zero
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offSet.width / 50)))
                )
                .background(
                    accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .cardFill(offSet.width)
                    
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offSet.width / 5.0))
        .offset(x: offSet.width * 5)
        .opacity(2 - Double(abs(offSet.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    offSet = gesture.translation
                })
                .onEnded({ _ in
                    if (offSet.width) > 100 {
                        removal?(true)
                    } else if (offSet.width) < -100 {
                        removal?(false)
                    }else {
                        offSet = .zero
                    }
                })
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offSet)
        
    }
}

#Preview {
    CardView(card: .example)
}
