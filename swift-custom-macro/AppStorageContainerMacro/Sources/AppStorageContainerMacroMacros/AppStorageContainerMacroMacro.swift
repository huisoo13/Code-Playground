import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct AppStorageContainerMacro: MemberMacro, MemberAttributeMacro {
    
    // MARK: - 1. MemberAttributeMacro 구현
    // 클래스 안의 변수(var)들을 찾아서 @AppStored 매크로를 몰래 붙여줍니다.
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AttributeSyntax] {
        // 변수이면서 연산 프로퍼티가 아닌(저장 프로퍼티인) 경우에만 적용
        guard let variableDecl = member.as(VariableDeclSyntax.self),
              variableDecl.bindingSpecifier.text == "var" else {
            return []
        }
        
        return [AttributeSyntax(stringLiteral: "@AppStored")]
    }
    
    // MARK: - 2. MemberMacro 구현
    // StorageFromMacro 구조체, 변수, init을 생성합니다.
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax], // ✨ 이 부분이 추가됨
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        var storageProperties: [String] = []
        var initAssignments: [String] = []
        
        for member in declaration.memberBlock.members {
            if let variable = member.decl.as(VariableDeclSyntax.self),
               let binding = variable.bindings.first,
               let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text,
               let type = binding.typeAnnotation?.type.description,
               let initializer = binding.initializer?.value.description {
                
                let appStorageLine = """
                    @AppStorage("\(identifier)_app_storage") var \(identifier): \(type) = \(initializer)
                    """
                storageProperties.append(appStorageLine)
                
                initAssignments.append("\(identifier) = storageFromMacro.\(identifier)")
            }
        }
        
        let structCode = """
            struct StorageFromMacro {
                \(storageProperties.joined(separator: "\n    "))
            }
            """
        
        let propertyCode = """
            private var storageFromMacro: StorageFromMacro
            """
        
        let initCode = """
            init() {
                storageFromMacro = StorageFromMacro()
                \(initAssignments.joined(separator: "\n    "))
            }
            """
        
        return [
            DeclSyntax(stringLiteral: propertyCode),
            DeclSyntax(stringLiteral: initCode),
            DeclSyntax(stringLiteral: structCode)
        ]
    }
}

public struct AppStoredMacro: AccessorMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        
        guard let variableDecl = declaration.as(VariableDeclSyntax.self),
              let binding = variableDecl.bindings.first,
              let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else {
            return []
        }
        
        // didSet 블록을 생성합니다.
        // 값이 바뀌면 storageFromMacro에도 값을 집어넣습니다.
        let didSetCode = """
        didSet {
            storageFromMacro.\(identifier) = self.\(identifier)
        }
        """
        
        return [AccessorDeclSyntax(stringLiteral: didSetCode)]
    }
}

@main
struct swift_custom_macroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AppStorageContainerMacro.self,
        AppStoredMacro.self
    ]
}
