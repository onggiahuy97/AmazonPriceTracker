//
//  ShareViewController.swift
//  AmazonShareExtensionApp
//
//  Created by Huy Ong on 9/16/23.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Process the incoming URL if available
        if let item = extensionContext?.inputItems.first as? NSExtensionItem,
           let attachments = item.attachments as? [NSItemProvider],
           let urlItem = attachments.first,
           urlItem.hasItemConformingToTypeIdentifier("public.url") {
            
            urlItem.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) in
                if let sharedURL = url as? URL {
                    // Handle the shared URL here
                    print("Shared URL: \(sharedURL)")
                }
            })
        }
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
