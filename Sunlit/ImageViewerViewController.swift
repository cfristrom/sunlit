//
//  ImageViewerViewController.swift
//  Sunlit
//
//  Created by Jonathan Hays on 5/9/20.
//  Copyright © 2020 Micro.blog, LLC. All rights reserved.
//

import UIKit

class ImageViewerViewController: UIViewController, UIScrollViewDelegate {

	@IBOutlet var image : UIImageView!
	@IBOutlet var scrollView : UIScrollView!
	
	var pathToImage = ""

    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonWithImage(named: "back_button", target: self, action: #selector(dismissViewController))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onShare))
		self.navigationItem.rightBarButtonItem?.tintColor = .black
		
		if let image = ImageCache.prefetch(pathToImage) {
			self.image.image = image
		}
		else {
			ImageCache.fetch(self.pathToImage) { (image) in
					DispatchQueue.main.async {
						self.image.image = image
					}
			}
		}
		
		self.scrollView.contentSize = self.image.frame.size
		self.image.frame = self.scrollView.bounds
		
		let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap))
		doubleTapGesture.numberOfTapsRequired = 2
		self.scrollView.addGestureRecognizer(doubleTapGesture)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.image.frame = self.scrollView.bounds
	}
	
	@objc func onDoubleTap() {
		if self.scrollView.zoomScale > 1.0 {
			UIView.animate(withDuration: 0.15) {
				self.scrollView.zoomScale = 1.0
			}
		}
		else {
			UIView.animate(withDuration: 0.15) {
				self.scrollView.zoomScale = self.scrollView.maximumZoomScale
			}
		}
	}
	
	@objc func onShare() {
		
		if let image = ImageCache.prefetch(self.pathToImage) {
			let items : [Any] = [image]
			let activities : [UIActivity]? = nil
			let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: activities)
			self.present(activityViewController, animated: true, completion: nil)
		}
	}
	
	@objc func dismissViewController() {
		self.navigationController?.popViewController(animated: true)
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return self.image
	}
}

