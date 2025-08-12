////
////  keyboardAdaptive.swift
////  Medicine Tracker
////
////  Created by admin on 7/13/23.
////
//
//import Foundation
//import SwiftUI
//import Combine
//
//
//
//class KeyboardAdaptiveModifier: ViewModifier {
//    typealias Body = <#type#>
//
//    private var keyboardNotification: AnyCancellable?
//
//    @Published private(set) var keyboardHeight: CGFloat = 0
//
//    init() {
//        subscribeToKeyboardEvents()
//    }
//
//    private func subscribeToKeyboardEvents() {
//        keyboardNotification = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
//            .compactMap { notification in
//                guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
//                    return nil
//                }
//                return keyboardFrame.height
//            }
//            .assign(to: \.keyboardHeight, on: self)
//    }
//}
import SwiftUI
import Foundation
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}


extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }

        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
