//
//  SoundEngine.swift
//  NilaiTukar
//
//  Created by Aris Yohanes Elean on 27/05/20.
//  Copyright © 2020 Aris Yohanes Elean. All rights reserved.
//

import AVFoundation

//class SoundEngine


class SoundEngine {
    
    var putarSuara: AVAudioPlayer?
    
    enum DataAudio: String {
        case hp = "01_keep_head_up.mp3"
        case hld = "02_hold_8_seconds.mp3"
        case btc = "03_slowly_back_to_center.mp3"
        case stl = "04_l_slowly_turn_left.mp3"
        case str = "05_r_slowly_turn_right.mp3"
        case ltl = "06_l_slowly_tilt_left.mp3"
        case rtr = "07_r_slowly_tilt_right.mp3"
        case lkd = "08_l_keep_down.mp3"
        case rkd = "09_r_keep_down.mp3"
    }
    
    init() {    }
    
    //pilihan angka 1 - 9.
    //1 = head up.
    //lihat enum utk lebih detail.
    
    func bunyikan(data: Int) {
        
        switch data
        {
        case 1:
            
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.hld.rawValue, ofType: nil)!
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)
                putarSuara?.play()
            } catch {
                print("Sorry, cannot play the audio resource.")
            }
            
            
        case 2:
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.hld.rawValue, ofType: nil)!
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)        } catch {
                    print("Sorry, cannot play the audio resource.")
            }
            
            
        case 3:
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.btc.rawValue, ofType: nil)!
            
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)        } catch {
                    print("Sorry, cannot play the audio resource.")
            }
            
        case 4:
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.stl.rawValue, ofType: nil)!
            
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)        } catch {
                    print("Sorry, cannot play the audio resource.")
            }
            
        case 5:
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.str.rawValue, ofType: nil)!
            
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)        } catch {
                    print("Sorry, cannot play the audio resource.")
            }
            
        case 6:
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.rtr.rawValue, ofType: nil)!
            
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)        } catch {
                    print("Sorry, cannot play the audio resource.")
            }
            
        case 7:
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.rtr.rawValue, ofType: nil)!
            
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)        } catch {
                    print("Sorry, cannot play the audio resource.")
            }
            
        case 8:
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.lkd.rawValue, ofType: nil)!
            
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)        } catch {
                    print("Sorry, cannot play the audio resource.")
            }
            
        case 9:
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.rkd.rawValue, ofType: nil)!
            
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)        } catch {
                    print("Sorry, cannot play the audio resource.")
            }
            
        default:
            let keberadaanFile = Bundle.main.path(forResource: DataAudio.hp.rawValue, ofType: nil)!
            
            let url = URL(fileURLWithPath: keberadaanFile)
            do {
                putarSuara = try AVAudioPlayer(contentsOf: url)        } catch {
                    print("Sorry, cannot play the audio resource.")
            }
            
        }
        
        
        
        
    }
    
}
