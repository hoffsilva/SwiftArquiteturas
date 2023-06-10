//
//  FirebaseConfig.swift
//  SwiftArquiteturasAPI
//
//  Created by Hoff Silva on 2023-06-10.
//

import FirebaseCore


public final class FirebaseConfig {
	
	public static func configureFirebase() {
		let bundle = Bundle(for: self)
		guard
			let googleServiceInfo = bundle.path(forResource: "GoogleService-Info", ofType: "plist"),
		let firOptions = FirebaseOptions(contentsOfFile: googleServiceInfo) else { fatalError() }
		if FirebaseApp.app() == nil { FirebaseApp.configure(options: firOptions) }
	}
	
}
