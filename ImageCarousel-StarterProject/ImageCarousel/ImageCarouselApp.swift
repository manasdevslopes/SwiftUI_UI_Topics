//
// Created for ImageCarousel
// by  Stewart Lynch on 2024-04-15
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch

import SwiftUI

@main
struct ImageCarouselApp: App {
    @State private var store = Store()
    var body: some Scene {
        WindowGroup {
            StartTab()
                .environment(store)
        }
    }
}

