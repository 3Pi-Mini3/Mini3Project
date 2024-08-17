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
    
    static let largeTitle: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .regular),
        .kern: -0.4,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 41
            return paragraphStyle
        }()
    ]
    
    static let title1: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .regular),
        .kern: 0.38,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 34
            return paragraphStyle
        }()
    ]
    
    static let title2: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 22) ?? UIFont.systemFont(ofSize: 22, weight: .regular),
        .kern: -0.26,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 28
            return paragraphStyle
        }()
    ]
    
    static let title3: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .regular),
        .kern: -0.45,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 25
            return paragraphStyle
        }()
    ]
    
    static let headline: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Semibold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold),
        .kern: -0.43,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 22
            return paragraphStyle
        }()
    ]
    
    static let body: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .regular),
        .kern: -0.43,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 22
            return paragraphStyle
        }()
    ]
    
    static let callout: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular),
        .kern: -0.31,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 21
            return paragraphStyle
        }()
    ]
    
    static let subhead: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular),
        .kern: -0.23,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 20
            return paragraphStyle
        }()
    ]
    
    static let footnote: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .regular),
        .kern: -0.08,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 18
            return paragraphStyle
        }()
    ]
    
    static let caption1: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular),
        .kern: 0,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 16
            return paragraphStyle
        }()
    ]
    
    static let caption2: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Regular", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .regular),
        .kern: 0.06,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 11
            return paragraphStyle
        }()
    ]
}


struct TypographyEmphasized {
    static let largeTitle: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .bold),
        .kern: -0.4,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 41
            return paragraphStyle
        }()
    ]
    
    static let title1: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Bold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold),
        .kern: 0.38,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 34
            return paragraphStyle
        }()
    ]
    
    static let title2: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Bold", size: 22) ?? UIFont.systemFont(ofSize: 22, weight: .bold),
        .kern: -0.26,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 28
            return paragraphStyle
        }()
    ]
    
    static let title3: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Semibold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .semibold),
        .kern: -0.45,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 25
            return paragraphStyle
        }()
    ]
    
    static let headline: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Semibold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold),
        .kern: -0.43,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 22
            return paragraphStyle
        }()
    ]
    
    static let body: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Semibold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold),
        .kern: -0.43,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 22
            return paragraphStyle
        }()
    ]
    
    static let callout: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Semibold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .semibold),
        .kern: -0.31,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 21
            return paragraphStyle
        }()
    ]
    
    static let subhead: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Semibold", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .semibold),
        .kern: -0.23,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 20
            return paragraphStyle
        }()
    ]
    
    static let footnote: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Semibold", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .semibold),
        .kern: -0.08,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 18
            return paragraphStyle
        }()
    ]
    
    static let caption1: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium),
        .kern: 0,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 16
            return paragraphStyle
        }()
    ]
    
    static let caption2: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-Semibold", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .semibold),
        .kern: 0.06,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 11
            return paragraphStyle
        }()
    ]
}


struct TypographyItalic {
    static let body: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-RegularItalic", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .regular),
        .kern: -0.43,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 22
            return paragraphStyle
        }()
    ]
    
    static let callout: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-RegularItalic", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular),
        .kern: -0.31,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 21
            return paragraphStyle
        }()
    ]
    
    static let subhead: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-RegularItalic", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular),
        .kern: -0.23,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 20
            return paragraphStyle
        }()
    ]
    
    static let footnote: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-RegularItalic", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .regular),
        .kern: -0.08,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 18
            return paragraphStyle
        }()
    ]
    
    static let caption1: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-RegularItalic", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular),
        .kern: 0,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 16
            return paragraphStyle
        }()
    ]
    
    static let caption2: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-RegularItalic", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .regular),
        .kern: 0.06,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 11
            return paragraphStyle
        }()
    ]
}


struct TypographyEmphasizedItalic {
    static let body: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-SemiboldItalic", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold),
        .kern: -0.43,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 22
            return paragraphStyle
        }()
    ]
    
    static let callout: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-SemiboldItalic", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .semibold),
        .kern: -0.31,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 21
            return paragraphStyle
        }()
    ]
    
    static let subhead: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-SemiboldItalic", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .semibold),
        .kern: -0.23,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 20
            return paragraphStyle
        }()
    ]
    
    static let footnote: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-SemiboldItalic", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .semibold),
        .kern: -0.08,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 18
            return paragraphStyle
        }()
    ]
    
    static let caption1: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-SemiboldItalic", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .semibold),
        .kern: 0,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 16
            return paragraphStyle
        }()
    ]
    
    static let caption2: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "SFPro-SemiboldItalic", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .semibold),
        .kern: 0.06,
        .paragraphStyle: {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 11
            return paragraphStyle
        }()
    ]
}
