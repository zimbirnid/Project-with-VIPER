// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Icons {
  internal enum AddPage {
    internal static let addButton = ImageAsset(name: "addButton")
    internal static let newRequest = ImageAsset(name: "newRequest")
    internal static let newWorker = ImageAsset(name: "newWorker")
  }
  internal enum Alert {
    internal static let alertImage = ImageAsset(name: "alertImage")
    internal static let failure = ImageAsset(name: "failure")
  }
  internal enum ClientsPage {
    internal static let filter = ImageAsset(name: "filter")
    internal static let som = ImageAsset(name: "som")
  }
  internal enum FilterView {
    internal static let fillCircle = ImageAsset(name: "fillCircle")
    internal static let filter = ImageAsset(name: "filter")
    internal static let freeCircle = ImageAsset(name: "freeCircle")
  }
  internal enum MainPage {
    internal static let comment = ImageAsset(name: "comment")
    internal static let logo = ImageAsset(name: "logo")
    internal static let logout = ImageAsset(name: "logout")
    internal static let notificationOff = ImageAsset(name: "notificationOff")
    internal static let notificationOn = ImageAsset(name: "notificationOn")
    internal static let pencil = ImageAsset(name: "pencil")
    internal static let threeDots = ImageAsset(name: "threeDots")
  }
  internal enum StudentsPage {
    internal static let studentCardIcon = ImageAsset(name: "studentCardIcon")
  }
  internal enum TabBar {
    internal enum Active {
      internal static let clients = ImageAsset(name: "clients")
      internal static let main = ImageAsset(name: "main")
      internal static let students = ImageAsset(name: "students")
      internal static let workers = ImageAsset(name: "workers")
    }
    internal enum InActive {
      internal static let iclients = ImageAsset(name: "iclients")
      internal static let imain = ImageAsset(name: "imain")
      internal static let istudents = ImageAsset(name: "istudents")
      internal static let iworkers = ImageAsset(name: "iworkers")
    }
    internal static let bell = ImageAsset(name: "bell")
  }
  internal enum TextFieldIcons {
    internal static let checkmark = ImageAsset(name: "checkmark")
    internal static let dropdown = ImageAsset(name: "dropdown")
    internal static let eye = ImageAsset(name: "eye")
    internal static let eyeSlash = ImageAsset(name: "eyeSlash")
    internal static let x = ImageAsset(name: "x")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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
