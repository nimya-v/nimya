//
//  ImagePickerMediatorMock.swift
//  TeamsChatTests
//
//  Created by Sameeksha Sharma on 09/04/23.
//

import InputBarAccessoryView
import XCTest
@testable import TeamsChat
import Combine

class ImagePickerMediatorMock: ImagePickerMediator {
    var isImagePickerCancelled: Bool = false
    var isImagePickerPickedImage: Bool = false

    override init(sender: Sender, mediator: MessageMediator) {
        super.init(sender: sender, mediator: mediator)
    }

    override func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        isImagePickerCancelled = true
    }

    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        isImagePickerPickedImage = true
    }
}
