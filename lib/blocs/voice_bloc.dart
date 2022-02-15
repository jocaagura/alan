import 'package:alan/const.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';

import '../interfaces/interfaces.dart';

class VoiceBloc extends Bloc {
  VoiceBloc() {
    debugPrint('Inicializando el asistente de voz ${AlanVoice.version}');
  }

  void addButton(){
    AlanVoice.removeButton();
    AlanVoice.addButton(
        kAlanKey,
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
  }

  void addCommand(command) {
    AlanVoice.onCommand.add((command) {
      debugPrint("I got new command ${command.toString()}");
    });
  }
}

final voiceBloc = VoiceBloc();
