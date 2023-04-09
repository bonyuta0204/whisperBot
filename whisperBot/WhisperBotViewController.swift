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

    let textField = NSTextField()
    
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            textField.topAnchor.constraint(equalTo: self.view.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        textField.rx.text.orEmpty.subscribe(onNext: { [weak self] text in
            print("text updated: \(text)")
            self?.handleTextFieldUpdate(text: text)
        }).disposed(by: disposeBag)
    }
    
    func handleTextFieldUpdate(text: String) {
        sendChatGPTRequest(prompt: text) { [weak self] result in
             switch result {
             case .success(let chatGPTResponse):
                 speakText(text: chatGPTResponse)
             case .failure(let error):
                 print("Error: \(error.localizedDescription)")
             }
         }
    }
    
}


extension WhisperBotViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> WhisperBotViewController {
    //1.
      let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    //2.
    let identifier = NSStoryboard.SceneIdentifier("WhisperBotViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? WhisperBotViewController else {
      fatalError("Why cant i find WhisperBotViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
