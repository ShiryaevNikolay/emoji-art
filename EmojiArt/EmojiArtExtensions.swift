//
//  EmojiArtExtensions.swift
//  EmojiArt
//
//  Created by shiryaev on 26.09.2023.
//

import SwiftUI

extension Collection where Element: Identifiable {
    func firstIndex(matching element: Element) -> Self.Index? {
        firstIndex(where: {$0.id == element.id})
    }
    
    func contains(matching element: Element) -> Bool {
        self.contains(where: {$0.id == element.id})
    }
}

extension URL {
    var imageURL: URL {
        for query in query?.components(separatedBy: "&") ?? [] {
            let queryComponents = query.components(separatedBy: "=")
            if queryComponents.count == 2 {
                if queryComponents[0] == "imgurl", let url = URL(string: queryComponents[1].removingPercentEncoding ?? "") {
                    return url
                }
            }
        }
        if isFileURL {
            var url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            url = url?.appendingPathComponent(self.lastPathComponent)
            if url != nil {
                return url!
            }
        }
        return self.baseURL ?? self
    }
}

extension Array where Element == NSItemProvider {
    func loadObjects<T>(ofType theType: T.Type, firstOnly: Bool = false, using load: @escaping (T) -> Void) -> Bool where T: NSItemProviderReading {
        if let provider = self.first(where: {$0.canLoadObject(ofClass: theType)}) {
            provider.loadObject(ofClass: theType) { object, error in
                if let value = object as? T
                {
                    DispatchQueue.main.async {
                        load(value)
                    }
                }
            }
            return true
        }
        return false
    }
}
