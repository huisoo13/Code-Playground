// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(member, names: named(StorageFromMacro), named(storageFromMacro), named(init))
@attached(memberAttribute)
public macro AppStorageContainer() = #externalMacro(module: "AppStorageContainerMacroMacros", type: "AppStorageContainerMacro")

@attached(accessor, names: named(didSet))
public macro AppStored() = #externalMacro(module: "AppStorageContainerMacroMacros", type: "AppStoredMacro")
