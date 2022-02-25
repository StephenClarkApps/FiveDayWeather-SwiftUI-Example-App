//
//  CellTextModifier.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 24/02/2022.
//

import SwiftUI

struct CellTextModifier: ViewModifier {
  func body(content: Content) -> some View {
    let boldFont = Font(UIFont.systemFont(ofSize: 12.0, weight: .bold))
    content
      .font(boldFont)
      .shadow(color: .secondary, radius: 1.0, x: 1, y: 1)
  }
}
