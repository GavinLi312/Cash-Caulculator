//
//  DataBaseHelper.swift
//  Zoonash
//
//  Created by Salamender Li on 24/8/18.
//  Copyright © 2018 Salamender Li. All rights reserved.
//
// reference: https://medium.com/@ankitbansal806/save-and-get-image-from-document-directory-in-swift-5c1280ec17f5
//save and retrive image from document


import UIKit
import CoreData

//// all icons are retrived from FlatIcon

class FileHelper: NSObject {
    
    
    //save image which is with a name in the local documentory
    func saveImageDocumentDirtory(imageName: String){
        let fileManager = FileManager.default
        let paths = (getDirectoryPath() as NSString).appendingPathComponent(imageName)
        let image = UIImage(named: imageName)
        let imageData = image?.pngData()
        fileManager.createFile(atPath: paths, contents: imageData, attributes: nil)
    }
    
    //save image and name in the local documentory
    func saveImageWithName(image:UIImage, name: String){
        let fileManager = FileManager.default
        let paths = (getDirectoryPath() as NSString).appendingPathComponent(name)
        let imageData = image.pngData()
        fileManager.createFile(atPath: paths, contents: imageData, attributes: nil)
    }
    
    // get local directoryPath
    func getDirectoryPath() -> String {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDiectory = (paths[0] as NSString).appendingPathComponent("DailySummary")
        if fileManager.fileExists(atPath: documentsDiectory) == false{
            do {
             try fileManager.createDirectory(atPath: documentsDiectory, withIntermediateDirectories: false, attributes: nil)
            }catch let error{
                print(error)
            }
        }
        return documentsDiectory
    }
    
    // get image by name
    func getImage(imageName:String) -> UIImage? {
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            return UIImage(contentsOfFile: imagePath)!
        }else{
            return nil
        }
    }
    
    // delete image by name
    func deleteImage(imageName:String) {
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(imageName)
        do{
            if fileManager.fileExists(atPath: imagePath) {
                try fileManager.removeItem(atPath: imagePath)
            }
        }catch{
            fatalError("cannot delete Image")
        }
    }
    
    func getAllFileListFromDirectory() -> [String]{
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(atPath: getDirectoryPath())
            return fileURLs
            // process files
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        return []
    }
    
    

}

