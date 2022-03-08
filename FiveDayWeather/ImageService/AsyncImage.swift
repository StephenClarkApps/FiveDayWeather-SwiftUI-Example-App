//
//  AsyncImage.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import SwiftUI
import Nuke
import FetchImage

public struct ImageView: View {
    @ObservedObject var image: FetchImage

    public var body: some View {
        ZStack {
            let url = URL(string: "https://cloud.githubusercontent.com/assets/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg")!
            ImageView(image: FetchImage(url: url))
                .frame(width: 80, height: 80)
                .clipped()
        }

    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        let url = URL(string: "https://cloud.githubusercontent.com/assets/1567433/9781817/ecb16e82-57a0-11e5-9b43-6b4f52659997.jpg")!
//        ImageView( simage: FetchImage(url: url))
//            .frame(width: 80, height: 80)
//            .clipped()
//    }
//}
