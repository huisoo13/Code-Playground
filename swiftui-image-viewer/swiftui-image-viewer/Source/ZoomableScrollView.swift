//
//  ZoomableScrollView.swift
//  swiftui-image-viewer
//
//  Created by Huisoo on 9/24/25.
//

import SwiftUI

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    @State var isZoomed: Bool = false
    @State var isZooming: Bool = false
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1.0
        scrollView.bouncesZoom = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        scrollView.backgroundColor = .clear

        let hostedView = UIHostingController(rootView: content)
        hostedView.view.translatesAutoresizingMaskIntoConstraints = false
        hostedView.view.backgroundColor = .clear
        
        scrollView.addSubview(hostedView.view)
        
        NSLayoutConstraint.activate([
            hostedView.view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            hostedView.view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            hostedView.view.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            hostedView.view.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            hostedView.view.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            hostedView.view.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
        
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // 줌 상태일때는 상위뷰의 스크롤 제거
        let zooming = isZoomed || isZooming
        DispatchQueue.main.async {
            var view: UIView? = uiView.superview
            while let current = view {
                if let scrollView = current as? UIScrollView {
                    if scrollView.isPagingEnabled || String(describing: type(of: scrollView)).contains("UIPage") {
                        scrollView.isScrollEnabled = !zooming
                        scrollView.panGestureRecognizer.isEnabled = !zooming
                        break
                    }
                }
                view = current.superview
            }
        }
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        private let parent: ZoomableScrollView
        
        init(_ parent: ZoomableScrollView) {
            self.parent = parent
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return scrollView.subviews.first
        }
        
        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.parent.isZooming = true
            }
        }
        
        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            if scale < 1.0 {
                scrollView.setZoomScale(1.0, animated: false)
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.parent.isZooming = false
                self.parent.isZoomed = (scale > 1.001)
            }
        }
        
        // Center the image when zoomed out
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            guard let view = scrollView.subviews.first else { return }
            
            let offsetX = max((scrollView.bounds.width - view.frame.width) * 0.5, 0)
            let offsetY = max((scrollView.bounds.height - view.frame.height) * 0.5, 0)
            
            scrollView.contentInset = UIEdgeInsets(
                top: offsetY,
                left: offsetX,
                bottom: 0,
                right: 0
            )
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.parent.isZoomed = (scrollView.zoomScale > 1.001)
                self.parent.isZooming = true
            }
        }
    }
}
