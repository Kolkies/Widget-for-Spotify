//
//  SpotifySignIn.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 28/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI

struct SpotifySignIn: View{
    var body: some View{
        HStack {
            Image("SpotifyIconWhite")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding([.top, .bottom], 12.0)
                .padding(.leading, 20.0)
            Text("Log in with Spotify")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding([.top, .bottom], 12)
                .padding(.leading, 4.0)
                .padding(.trailing, 20.0)
            
        }
        .background(Color.green)
        .cornerRadius(17.5)
    }
}

struct SpotifySignIn_Previews: PreviewProvider {
    static var previews: some View {
        SpotifySignIn()
    }
}
