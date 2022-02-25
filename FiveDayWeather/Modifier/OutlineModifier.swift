//
//  OutlineModifier.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 24/02/2022.
//

import SwiftUI

// ViewModifiers can make our code cleaner and can apply the principle of reuse when used more than one
struct OutlineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(4)
            .border(.gray, width: 0.5)
    }
}
