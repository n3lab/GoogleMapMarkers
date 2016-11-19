//
//  Message.swift
//  GoogleMapMarkers
//
//  Created by n3deep on 19.11.16.
//  Copyright © 2016 n3deep. All rights reserved.
//

import UIKit

class Message {
    func onDistance(distance: Int) {
        if (distance == 0) {
            let alert = UIAlertController(title: "Сообщение",
                                          message: "Вы тут!",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        if (distance <= 20) {
            let alert = UIAlertController(title: "Сообщение",
                                          message: "Вы около маркера. Расстояние до цели: \(distance)",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        if (distance > 20) {
            let alert = UIAlertController(title: "Сообщение",
                                          message: "Вы находитесь далеко. Расстояние до цели: \(distance)",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
