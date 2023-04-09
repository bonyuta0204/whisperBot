//
//  TextToSpeech.swift
//  whisperBot
//
//  Created by Yuta Nakamura on 2023/04/09.
//

import Cocoa

func speakText(text: String) {
    let speechSynthesizer = NSSpeechSynthesizer()
    speechSynthesizer.startSpeaking(text)
}
