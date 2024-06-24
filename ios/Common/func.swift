import Foundation
import WidgetKit
import SwiftUI
import UIKit

func cutomFont(fontFamily: String) -> Void {
   CTFontManagerRegisterFontsForURL(bundle.appending(path: "assets/font/\(fontFamily).ttf") as CFURL, CTFontManagerScope.process, nil)
}

func loadJson <T: Decodable>(json: String) -> T {
    do {
        let data = json.data(using: .utf8)!
        return try JSONDecoder().decode(T.self, from: Data(data))
      } catch {
          fatalError("Unable to parse json: (error)")
    }
}

func isWidgetML(widgetFamily: WidgetFamily) -> Bool {
    if(widgetFamily == .systemMedium || widgetFamily == .systemLarge){
        return true
    }
    
    return false
}
