import SwiftUI

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

public struct ImageView: View {
    let urlString: String?
    let placeholder: UIImage?
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = true
    @State private var loadError: Bool = false

    public init(urlString: String?, placeholder: UIImage?) {
        self.urlString = urlString
        self.placeholder = placeholder
    }

    public var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if loadError {
                if let placeholder = placeholder {
                    Image(uiImage: placeholder)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Failed to load image")
                }
            } else {
                LoadingView(width: 24, height: 24)
                    .task {
                        await loadImage()
                    }
            }
        }
    }

    private func loadImage() async {
        if let urlString,
           let cachedImage = ImageCache.shared.object(forKey: urlString as NSString) {
            self.image = cachedImage
            self.isLoading = false
            return
        }

        guard let urlString,
              let url = URL(string: urlString) else {
            loadError = true
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let uiImage = UIImage(data: data) {
                ImageCache.shared.setObject(uiImage, forKey: urlString as NSString)
                self.image = uiImage
            } else {
                loadError = true
            }
        } catch {
            print("Error loading image: \(error.localizedDescription)")
            loadError = true
        }
        
        isLoading = false
    }
}
