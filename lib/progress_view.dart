import 'package:flutter/material.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({Key? key}) : super(key: key);

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  late final TextEditingController _textController;
  late double _progress;
  late bool _isCheckboxChecked;
  late String _progressBarText;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _progress = 0;
    _isCheckboxChecked = false;
    _progressBarText = '';
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _textController,
            ),
            LinearProgressIndicator(
              value: _progress,
            ),
            CheckboxListTile(
              title: const Text('Вы уверены?'),
              value: _isCheckboxChecked,
              onChanged: _changeToggleValue,
            ),
            Text(_getProgressBarText()),
            ElevatedButton(
              onPressed: _setProgress,
              child: const Text('Progress'),
            ),
          ],
        ),
      ),
    );
  }

  String _getProgressBarText() {
    if (_progressBarText.isNotEmpty) {
      return _progressBarText;
    }

    return 'Здесь будет отображён текст, который Вы ввели';
  }

  void _changeToggleValue(bool? checkboxStatus) {
    if (checkboxStatus != null) {
      setState(() {
        _isCheckboxChecked = checkboxStatus;
      });
    }
  }

  void _setProgress() {
    final textFieldText = _textController.text;
    if (textFieldText.isNotEmpty && _isCheckboxChecked) {
      setState(() {
        _progressBarText = textFieldText;
        final newProgress = _progress + 0.1;
        _progress = newProgress < 1 ? newProgress : 0;
      });
    }
  }
}
