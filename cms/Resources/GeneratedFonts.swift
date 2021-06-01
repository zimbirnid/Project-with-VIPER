// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit.UIFont
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum Fonts {
    internal enum GothamPro {
        internal static let regular = FontConvertible(name: "GothamPro", family: "Gotham Pro", path: "GothaProReg.otf")
        internal static let black = FontConvertible(name: "GothamPro-Black", family: "Gotham Pro", path: "GothaProBla.otf")
        internal static let blackItalic = FontConvertible(name: "GothamPro-BlackItalic", family: "Gotham Pro", path: "GothaProBlaIta.otf")
        internal static let bold = FontConvertible(name: "GothamPro-Bold", family: "Gotham Pro", path: "GothaProBol.otf")
        internal static let boldItalic = FontConvertible(name: "GothamPro-BoldItalic", family: "Gotham Pro", path: "GothaProBolIta.otf")
        internal static let italic = FontConvertible(name: "GothamPro-Italic", family: "Gotham Pro", path: "GothaProIta.otf")
        internal static let light = FontConvertible(name: "GothamPro-Light", family: "Gotham Pro", path: "GothaProLig.otf")
        internal static let lightItalic = FontConvertible(name: "GothamPro-LightItalic", family: "Gotham Pro", path: "GothaProLigIta.otf")
        internal static let medium = FontConvertible(name: "GothamPro-Medium", family: "Gotham Pro", path: "GothaProMed.otf")
        internal static let mediumItalic = FontConvertible(name: "GothamPro-MediumItalic", family: "Gotham Pro", path: "GothaProMedIta.otf")
        internal static let all: [FontConvertible] = [regular, black, blackItalic, bold, boldItalic, italic, light, lightItalic, medium, mediumItalic]
    }
    internal enum GothamProNarrow {
        internal static let bold = FontConvertible(name: "GothamProNarrow-Bold", family: "Gotham Pro Narrow", path: "GothaProNarBol.otf")
        internal static let medium = FontConvertible(name: "GothamProNarrow-Medium", family: "Gotham Pro Narrow", path: "GothaProNarMed.otf")
        internal static let all: [FontConvertible] = [bold, medium]
    }
    internal static let allCustomFonts: [FontConvertible] = [GothamPro.all, GothamProNarrow.all].flatMap { $0 }
    internal static func registerAllCustomFonts() {
        allCustomFonts.forEach { $0.register() }
    }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
    internal let name: String
    internal let family: String
    internal let path: String
    
    #if os(OSX)
    internal typealias Font = NSFont
    #elseif os(iOS) || os(tvOS) || os(watchOS)
    internal typealias Font = UIFont
    #endif
    
    internal func font(size: CGFloat) -> Font {
        guard let font = Font(font: self, size: size) else {
            fatalError("Unable to initialize font '\(name)' (\(family))")
        }
        return font
    }
    
    internal func register() {
        // swiftlint:disable:next conditional_returns_on_newline
        guard let url = url else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }
    
    fileprivate var url: URL? {
        // swiftlint:disable:next implicit_return
        return BundleToken.bundle.url(forResource: path, withExtension: nil)
    }
}

internal extension FontConvertible.Font {
    convenience init?(font: FontConvertible, size: CGFloat) {
        #if os(iOS) || os(tvOS) || os(watchOS)
        if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
            font.register()
        }
        #elseif os(OSX)
        if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
            font.register()
        }
        #endif
        
        self.init(name: font.name, size: size)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }()
}
// swiftlint:enable convenience_type
