//
//  Fonts.swift
//  bemLembrar
//
//  Created by Henrique Semmer on 17/11/23.
//

import Foundation
import SwiftUI

extension Font {
    
    func largeTitle() -> Font {
        return Font.custom("BricolageGrotesque-Bold", size: 34, relativeTo: .largeTitle)
    }
    
    func title() -> Font {
        return Font.custom("BricolageGrotesque-Bold", size: 28, relativeTo: .title)
    }
    
    func title2() -> Font {
        return Font.custom("Lato-Bold", size: 22, relativeTo: .title2)
    }
    
    func title3() -> Font {
        return Font.custom("Lato-Bold", size: 20, relativeTo: .title3)
    }
    
    func headline() -> Font {
        return Font.custom("Lato-Bold", size: 17, relativeTo: .headline)
    }
    
    func body() -> Font {
        return Font.custom("Lato-Regular", size: 17, relativeTo: .body)
    }
    
    func callout() -> Font {
        return Font.custom("Lato-Bold", size: 16, relativeTo: .callout)
    }
    
    func subheadline() -> Font {
        return Font.custom("Lato-Bold", size: 15, relativeTo: .subheadline)
    }
    
    func footnote() -> Font {
        return Font.custom("Lato-Regular", size: 13, relativeTo: .footnote)
    }
    
    func caption1() -> Font {
        return Font.custom("Lato-Regular", size: 12, relativeTo: .caption)
    }
    
    func caption2() -> Font {
        return Font.custom("Lato-Regular", size: 11, relativeTo: .caption2)
    }
}
