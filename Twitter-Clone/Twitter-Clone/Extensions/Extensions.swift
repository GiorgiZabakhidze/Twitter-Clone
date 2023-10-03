//
//  Extensions.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
