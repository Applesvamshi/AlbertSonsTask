//
//  ContentView.swift
//  Demo
//
//  Created by Vamshi on 17/07/24.

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.error {
                    Text("Error: \(error)")
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: columns, alignment: .top, spacing: 20) {
                            ForEach(viewModel.hits) { hit in
                                VStack(alignment: .leading) {
                                    VStack{
                                        AsyncImageLoader(url: URL(string: hit.previewURL ?? ""))
                                                        .frame(height: 100)
                                                        .cornerRadius(8)
                                                        .background(Color.gray.opacity(0.2))
                                        
                                        VStack(alignment: .leading) {
                                            Text(hit.tags ?? "")
                                                .padding(.bottom, 10)
                                                .frame(width: 100)
                                            Button(action: {
                                                print("Button tapped  ")
                                            }) {
                                                Text(hit.type ?? "")
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        .padding()
                                    }
                                    .frame(width: 150)
                                    .padding()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
            }
        }
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }


struct AsyncImageLoader: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Image

    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let url: URL?
    private var cancellable: AnyCancellable?

    init(url: URL?) {
        self.url = url
    }

    func load() {
        guard let url = url else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}

