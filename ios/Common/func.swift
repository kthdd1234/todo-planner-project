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

func isWidgetSM(widgetFamily: WidgetFamily) -> Bool {
    if(widgetFamily == .systemSmall || widgetFamily == .systemMedium){
        return true
    }
    
    return false
}

func isWidgetML(widgetFamily: WidgetFamily) -> Bool {
    if(widgetFamily == .systemMedium || widgetFamily == .systemLarge){
        return true
    }
    
    return false
}

func color(rgb: [Double]?) -> Color? {
    if(rgb == nil) {
        return nil
    }
    
    return Color(red: rgb![0]/255, green: rgb![1]/255, blue: rgb![2]/255)
}

func prefixList(widgetFamily: WidgetFamily, list: [ItemModel]) -> [ItemModel] {
    if isWidgetSM(widgetFamily: widgetFamily) {
        return Array(list.prefix(3))
    }
    
    return Array(list.prefix(10))
}


