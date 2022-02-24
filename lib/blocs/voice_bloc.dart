import 'package:alan_voice/alan_voice.dart';

import '../const.dart';
import '../interfaces/bloc_interface.dart';

class VoiceBloc extends Bloc {
  VoiceBloc() {
    AlanVoice.onCommand.add((command) {
      executeCommand(command.data);
    });
  }

  bool _existButton = false;
  final Map<String, Function> _commands = {};

  void addButton() {
    if (!_existButton) {
      AlanVoice.removeButton();
      AlanVoice.addButton(kAlanKey, buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
      _existButton = true;
    }
  }

  void removeButton() {
    _existButton = false;
    AlanVoice.removeButton();
  }

  void addCommand(String key, void Function() function) {
    _commands[key] = function;
  }

  void executeCommand(Map<String, dynamic> commandMap) {
    String? key = commandMap['command'];
    if (key != null && _commands[key] != null) {
      _commands[key]!();
    }
  }

  void setVisuals(String screen) {
    var visual = '{"screen":"$screen"}';
    AlanVoice.setVisualState(visual);
  }

  @override
  dispose() {}
}

final voiceBloc = VoiceBloc();
