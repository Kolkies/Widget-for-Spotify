//
//  GMobBanner.swift
//  Widget for Spotify
//
//  Created by Bram Koene on 28/09/2020.
//  Copyright © 2020 Sjoerd Bolten. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final private class BannerVC: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeLargeBanner)

        let viewController = UIViewController()
//        view.adUnitID = "ca-app-pub-3940256099942544/2934735716" // Test Unit
        view.adUnitID = "ca-app-pub-3425399211312777/4125460611" // Prod Unit
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeLargeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner:View{
    var body: some View{
        HStack{
            Spacer()
            BannerVC().frame(width: 320, height: 100, alignment: .center)
            Spacer()
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}


final private class BannerVC2: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeMediumRectangle)

        let viewController = UIViewController()
//        view.adUnitID = "ca-app-pub-3940256099942544/2934735716" // Test Unit
        view.adUnitID = "ca-app-pub-3425399211312777/5443014358" // Prod Unit
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeMediumRectangle.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner2:View{
    var body: some View{
        HStack{
            Spacer()
            BannerVC2().frame(width: 300, height: 250, alignment: .center)
            Spacer()
        }
    }
}

struct Banner2_Previews: PreviewProvider {
    static var previews: some View {
        Banner2()
    }
}
