import Foundation
import SwiftUI

// Group Id
public var widgetGroupId = "group.todo-planner-widget"

// bundle
var bundle: URL {
            let bundle = Bundle.main
            if bundle.bundleURL.pathExtension == "appex" {
                var url = bundle.bundleURL.deletingLastPathComponent().deletingLastPathComponent()
                url.append(component: "Frameworks/App.framework/flutter_assets")
                return url
            }
        return bundle.bundleURL
}

// widgetBgColor
public var widgetBgColor: Color = Color(red: 243/255, green: 244/255, blue: 249/255)