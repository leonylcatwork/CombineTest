//
//  ViewController.swift
//  CombineTest
//
//  Created by leon on 04/05/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    private let formatter = DateFormatter()
    private var cancellables = [AnyCancellable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        textView.text = "\(formattedDateString()) started\n"
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.layoutManager.allowsNonContiguousLayout = false
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        button.setTitleColor(.white, for: .highlighted)

        button.publisher(for: .touchUpInside)
            .throttle(for: 1, scheduler: DispatchQueue.main, latest: false)
            .sink { [weak self] button in
                self?.tapped(button as! UIButton)
            }
            .store(in: &cancellables)
    }

    func tapped(_ button: UIButton) {
        var text = textView.text
        text?.append("\(formattedDateString()) tapped\n")
        textView.text = text
        let stringLength = textView.text.count
        textView.scrollRangeToVisible(NSMakeRange(stringLength - 1, 0))
    }

    private func formattedDateString() -> String {
        formatter.string(from: Date())
    }
}
