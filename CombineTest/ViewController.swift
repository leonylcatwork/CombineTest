//
//  ViewController.swift
//  CombineTest
//
//  Created by leon on 04/05/2021.
//

import UIKit
import Combine
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    private let formatter = DateFormatter()
    private var cancellables = [AnyCancellable]()
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        textView.text = "\(formattedDateString()) started\n"
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.layoutManager.allowsNonContiguousLayout = false
        button1.layer.cornerRadius = 10
        button1.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        button1.setTitleColor(.white, for: .highlighted)
        button2.layer.cornerRadius = 10
        button2.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        button2.setTitleColor(.white, for: .highlighted)

        button1.publisher(for: .touchUpInside)
            .throttle(for: 1, scheduler: DispatchQueue.main, latest: false)
            .sink { [weak self] button in
                self?.tapped("Combine")
            }
            .store(in: &cancellables)

        button2.rx.tap
            .throttle(.microseconds(1000), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tapped("RxSwift")
            }, onDisposed: {
                print("disposed")
            })
            .disposed(by: disposeBag)
    }

    func tapped(_ string: String) {
        var text = textView.text
        text?.append("\(formattedDateString()) \(string)\n")
        textView.text = text
        let stringLength = textView.text.count
        textView.scrollRangeToVisible(NSMakeRange(stringLength - 1, 0))
    }

    private func formattedDateString() -> String {
        formatter.string(from: Date())
    }
}
