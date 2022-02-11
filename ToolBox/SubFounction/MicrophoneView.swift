//
//  MicrophoneView.swift
//  ToolBox
//
//  Created by bytedance on 2022/2/7.
//

import SwiftUI
import AVFoundation

struct MicrophoneView: View {
    @State var playing:Int = -1
    @State var record:Bool = false
    @State var session:AVAudioSession!
    @State var recorder:AVAudioRecorder!
    @State var audio_Play:AVAudioPlayer!
    @State var showAlert = false
    @State var audios:[URL] = []
    
    
    var body: some View {
        VStack{
            List{
                ForEach(Array(self.audios.enumerated()), id: \.offset){ index, element in
                    HStack {
                        Text(element.relativeString)
                            .onTapGesture {
                                self.playSound(soundURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(element.relativeString)"))
                                playing = index
                                print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(element.relativeString)"))
                            }
                        if (playing == index) {
                            Spacer()
                            Text("🎵")
                        }
                    }
                }
                .onDelete { IndexSet in
                    audios.remove(atOffsets: IndexSet)
                }
            }
            .navigationBarItems(trailing: EditButton())
           
            Button(action: {
                do {
                    if self.record{
                        self.recorder.stop()
                        self.record.toggle()
                        self.getAudios()
                        return
                    }
                    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    let fileName = url.appendingPathComponent("myrcd\(self.audios.count + 1).m4a")
                    let settings = [
                        AVFormatIDKey:Int(kAudioFormatMPEG4AAC),
                        AVSampleRateKey:12000,
                        AVNumberOfChannelsKey:1,
                        AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                    ]
                    print("save \(fileName)")
                    self.recorder = try AVAudioRecorder(url: fileName, settings: settings)
                    self.recorder.record()
                    self.record.toggle()
                } catch  {
                    print(error.localizedDescription)
                }
            }, label: {
                ZStack{
                    Circle().fill(Color.red).frame(width: 70, height: 70)
                    if record {
                        Circle().stroke(Color.yellow,lineWidth: 5).frame(width: 65, height: 65)
                    }
                }
            })
            .padding(.vertical,25)
        }
        .onAppear {
            do{
                self.session = AVAudioSession.sharedInstance()
                try self.session.setCategory(.playAndRecord, mode: .default, policy: .default, options:[ .allowBluetoothA2DP,.allowAirPlay,.allowBluetooth,.defaultToSpeaker])
              //扬声器，蓝牙播放
                self.session.requestRecordPermission { hasPermission in
                    if !hasPermission{
                        self.showAlert.toggle()
                    }else{
                        self.getAudios()
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    //播放
    func playSound(soundURL:URL){
        do {
            try audio_Play = AVAudioPlayer(contentsOf: soundURL)
//            audio_Play.volume = 1.0
            audio_Play.numberOfLoops = 0
            audio_Play.play()
        } catch  {
            print(error.localizedDescription)
        }
    }

    func getAudios(){
        do {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let result = try FileManager.default.contentsOfDirectory(at: url,includingPropertiesForKeys: nil,options: .producesRelativePathURLs)
            self.audios.removeAll()
            for i in result {
                self.audios.append(i)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct MicrophoneView_Previews: PreviewProvider {
    static var previews: some View {
        MicrophoneView()
    }
}
