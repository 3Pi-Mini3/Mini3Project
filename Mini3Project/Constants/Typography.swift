//
//  Typography.swift
//  Mini3Project
//
//  Created by Lucky on 18/08/24.
//

import UIKit

// NOTE: Example usage of typography settings for a large title
//
//  let largeTitleLabel = UILabel()
//  let largeTitleAttributedString = NSAttributedString(
//      string: "Large Title",
//      attributes: TypographyRegular.largeTitle
//  )
//  largeTitleLabel.attributedText = largeTitle
//

struct TypographyRegular {
    
    static let largeTitle: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 41
        let font = UIFont(name: "SFPro-Regular", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight

        return [
            .font: font,
            .kern: -0.4,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let title1: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 34
        let font = UIFont(name: "SFPro-Regular", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0.38,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let title2: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 28
        let font = UIFont(name: "SFPro-Regular", size: 22) ?? UIFont.systemFont(ofSize: 22, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.26,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let title3: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 25
        let font = UIFont(name: "SFPro-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.45,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let headline: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 22
        let font = UIFont(name: "SFPro-Semibold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.43,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let body: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 22
        let font = UIFont(name: "SFPro-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.43,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let callout: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 21
        let font = UIFont(name: "SFPro-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.31,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let subhead: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 20
        let font = UIFont(name: "SFPro-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.23,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let footnote: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 18
        let font = UIFont(name: "SFPro-Regular", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.08,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let caption1: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 16
        let font = UIFont(name: "SFPro-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let caption2: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 11
        let font = UIFont(name: "SFPro-Regular", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0.06,
            .paragraphStyle: paragraphStyle
        ]
    }()
}


struct TypographyEmphasized {
    static let largeTitle: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 41
        let font = UIFont(name: "SFPro-Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.4,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let title1: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 34
        let font = UIFont(name: "SFPro-Bold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0.38,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let title2: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 28
        let font = UIFont(name: "SFPro-Bold", size: 22) ?? UIFont.systemFont(ofSize: 22, weight: .bold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.26,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let title3: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 25
        let font = UIFont(name: "SFPro-Semibold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.45,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let headline: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 22
        let font = UIFont(name: "SFPro-Semibold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.43,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let body: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 22
        let font = UIFont(name: "SFPro-Semibold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.43,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let callout: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 21
        let font = UIFont(name: "SFPro-Semibold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.31,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let subhead: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 20
        let font = UIFont(name: "SFPro-Semibold", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.23,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let footnote: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 18
        let font = UIFont(name: "SFPro-Semibold", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.08,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let caption1: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 16
        let font = UIFont(name: "SFPro-Semibold", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let caption2: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 11
        let font = UIFont(name: "SFPro-Semibold", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0.06,
            .paragraphStyle: paragraphStyle
        ]
    }()
}


struct TypographyItalic {
    static let body: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 22
        let font = UIFont(name: "SFPro-RegularItalic", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.43,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let callout: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 21
        let font = UIFont(name: "SFPro-RegularItalic", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.31,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let subhead: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 20
        let font = UIFont(name: "SFPro-RegularItalic", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.23,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let footnote: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 18
        let font = UIFont(name: "SFPro-RegularItalic", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.08,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let caption1: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 16
        let font = UIFont(name: "SFPro-RegularItalic", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let caption2: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 13
        let font = UIFont(name: "SFPro-RegularItalic", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0.06,
            .paragraphStyle: paragraphStyle
        ]
    }()
}


struct TypographyEmphasizedItalic {
    static let body: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 22
        let font = UIFont(name: "SFPro-SemiboldItalic", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.43,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let callout: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 21
        let font = UIFont(name: "SFPro-SemiboldItalic", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.31,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let subhead: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 20
        let font = UIFont(name: "SFPro-SemiboldItalic", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.23,
            .paragraphStyle: paragraphStyle
        ]
    }()

    static let footnote: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 18
        let font = UIFont(name: "SFPro-SemiboldItalic", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: -0.08,
            .paragraphStyle: paragraphStyle
        ]
    }()
    
    static let caption1: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 16
        let font = UIFont(name: "SFPro-SemiboldItalic", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0,
            .paragraphStyle: paragraphStyle
        ]
    }()

    static let caption2: [NSAttributedString.Key: Any] = {
        let lineHeight: CGFloat = 13
        let font = UIFont(name: "SFPro-SemiboldItalic", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .semibold)
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Calculate lineSpacing to achieve the desired lineHeight
        let fontLineHeight = font.lineHeight
        paragraphStyle.lineSpacing = lineHeight - fontLineHeight
        
        return [
            .font: font,
            .kern: 0.06,
            .paragraphStyle: paragraphStyle
        ]
    }()
}
