//
//  WhisperBotViewController.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/10.
//

import Cocoa
import RxCocoa
import RxSwift

class WhisperBotViewController: NSViewController {
    @IBOutlet var textField: NSTextField!
    
    let disposeBag = DisposeBag()

    let chatGPT = ChatGPTAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.rx.text.orEmpty.subscribe(onNext: { [weak self] text in
            print("text updated: \(text)")
            self?.handleTextFieldUpdate(text: text)
        }).disposed(by: disposeBag)
    }

    func handleTextFieldUpdate(text: String) {
        chatGPT.sendTextToChatGPT(text: text)
    }
}

extension WhisperBotViewController {
    // MARK: Storyboard instantiation

    static func freshController() -> WhisperBotWindowController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("WhisperBotWindowController")
        guard let windowController = storyboard.instantiateController(withIdentifier: identifier) as? WhisperBotWindowController else {
            fatalError("Why cant i find WhisperBotWindowController? - Check Main.storyboard")
        }
        return windowController
    }
}
