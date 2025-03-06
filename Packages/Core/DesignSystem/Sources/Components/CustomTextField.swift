import SwiftUI

public struct CustomTextField: View {
    let placeholder: String
    let placeholderColor: Color
    let borderColor: Color
    let textColor: Color
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType?
    let disabled: Bool
    let onChange: ((String) -> Void)?
    
    @Binding var field: String
    @State private var localField: String
    
    public init(field: Binding<String>,
                borderColor: Color = .gray,
                textColor: Color = Color(.label),
                placeholder: String,
                placeholderColor: Color = .gray,
                keyboardType: UIKeyboardType = .default,
                textContentType: UITextContentType? = .none,
                disabled: Bool = false,
                onChange: ((String) -> Void)?) {
        self._field = field
        self.borderColor = borderColor
        self.textColor = textColor
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.disabled = disabled
        self.onChange = onChange
        _localField = State(initialValue: field.wrappedValue)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12, content: {
            TextField("",
                      text: $localField,
                      prompt: Text(placeholder)
                .foregroundColor(placeholderColor))
            .accentColor(.orange)
            .autocapitalization(.none)
            .keyboardType(keyboardType)
            .textContentType(textContentType)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: 1.0))
            .foregroundColor(textColor)
            .disabled(disabled)
        })
        .onChange(of: localField) { text in
            onChange?(text)
        }
    }
}
