//
//  MainView.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 26/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI
import WidgetKit

struct MainView: View {
    @ObservedObject var spotifyData = SpotifyData.shared
    
    @State private var devMode = true
    
    @State private var showingAlert = false
    
    @State var backgroundColor: Color = Color.white
    @State var textColor: Color = Color.black
    @State var currentPreviewFamily: WidgetSizes = WidgetSizes.mediumCurrent
    
    init(){
        if(UserDefaults.init().bool(forKey: "hasLaunchedBefore")){
            showingAlert = true
            UserDefaults.init().setValue(false, forKey: "hasLaunchedBefore")
        }
    }
    
    var body: some View {
        TabView{
            NavigationView{
                HStack {
                    ZStack{
                        VStack(alignment: .leading) {
                            Text("Welcome " + (spotifyData.personInfo?.display_name ?? "User"))
                                .font(.headline)
//                            Text("Available Widgets: ")
//                                .font(.subheadline)
                            Divider()
//                            Picker(selection: $currentPreviewFamily, label: Text("Widget Size")) {
//                                ForEach(WidgetSizes.allCases, id: \.self) {
//                                    Text($0.rawValue == "smallCurrent" ? "Small" : "Medium")
//                                }
//                            }
//                            .pickerStyle(SegmentedPickerStyle())
                            ZStack{
//                                if(currentPreviewFamily == WidgetSizes.smallCurrent){
//                                    ZStack(alignment: .leading){
//                                        RoundedRectangle(cornerRadius: 20)
//                                            .aspectRatio(1.0, contentMode: .fit)
//                                        SmallCurrent(data: getExampleModel(context: spotifyData.currentlyPlayingContext), isInApp: true)
//                                    }
//                                } else if(currentPreviewFamily == WidgetSizes.mediumCurrent){
                                    MediumCurrent(data: getExampleModel(context: spotifyData.currentlyPlayingContext), isInApp: true)
//                                }
                            }
                            .frame(maxHeight: 160)
                            Divider()
                            ScrollView{
//                                VStack{
//                                    Text("Widget Config: ")
//                                        .font(.headline)
//                                    ColorPicker("Text Color", selection: $textColor, supportsOpacity: false)
//                                    ColorPicker("Background Color", selection: $backgroundColor, supportsOpacity: false)
//                                }
                                Text("To add one or more of the widgets, please make sure your iPhone is running iOS 14 or later.\n\n1. Long press on your homescreen to go into 'jiggle mode'.\n2. Click the '+' icon in the top-left corner\n3. Search for the Spotify widget, and follow the instructions given.\n\nProtip: if you don't want the background of the widget to change, long press on the widget, tap 'Edit Widget' and disable 'Dynamic background'. It will then follow your system theme (dark/light)!\n\nProtip 2: Due to limitations from iOS, the widget may not update live and you’ll have to click on the widget to refresh. Just open the app by clicking the widget. Then you can directly close the app. This will force a refresh. We are working on a fix :)")
                                    .padding(5)
                            }
                            if(!devMode){
                                Banner()
                            }
                        }
                        .navigationBarTitle("Home")
                        .navigationBarItems(trailing:
                            Button(action: {
                                showingAlert = true
                            }) {
                                Image(systemName: "info.circle").imageScale(.large)
                            }
                            .alert(isPresented: $showingAlert){
                                Alert(title: Text("Unable to refresh continuously"), message: Text("Due to limitations from iOS, the widget may not update live and you’ll have to click on the widget to refresh :)"), dismissButton: .default(Text("Got it!")))
                            }
                        )
                        Spacer()
                    }.padding(.leading, 5)
                }
                .padding(.horizontal, 15)
            }
            .tabItem {
                Image(systemName: "music.note.list")
                Text("Home")
            }
            
            NavigationView{
                SettingsPage()
                    .navigationBarTitle("Settings")
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
        .onAppear {
            SpotifyData.shared.getPersonInfo()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
            MainView()
        }
    }
}


struct CardView: View {
    let card: Card

    var body: some View {
        ZStack {
            Image("TestImage")
                .resizable()
                .scaledToFill()
                .frame(width: .infinity, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            VStack(alignment: .leading) {
                Spacer()
                ZStack {
                    BlurView(style: .light).frame(width: .infinity, height: 60)
                    Text(card.prompt)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.black)
//                        .padding(20)
                }
                .multilineTextAlignment(.center)
            }
        }
        .cornerRadius(15)
        .frame(width: .infinity, height: 200)
    }
}


struct Card {
    let prompt: String
}

struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {

    }

}
