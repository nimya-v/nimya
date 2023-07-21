//
//  LocalFileManager.swift
//  TeamsChat
//
//  Created by Rohit Chauhan on 06/04/23.
//

import Foundation

/**
    `FileManagerProtocol` Define method to get data from Bundle's file
 */
protocol FileManagerProtocol {
    /// Get data from file
    /// - Parameters:
    ///   - filename:
    ///   - fileExtension:
    func data(for filename: String, fileExtension: String) throws -> Result<Data, FileError>
}

extension FileManagerProtocol {
    func data(for filename: String, fileExtension: String = "json") throws -> Result<Data, FileError> {
        guard let jsonfileurl = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
            throw FileError.fileNotExist
        }

        do {
            let data = try Data(contentsOf: jsonfileurl)
            return .success(data)
        } catch {
            throw FileError.failure(error)
        }
    }
}

// MARK: - File Error
enum FileError: Error {
    case fileNotExist
    case failure(Error)
}

struct LocalFileManager: FileManagerProtocol {}
