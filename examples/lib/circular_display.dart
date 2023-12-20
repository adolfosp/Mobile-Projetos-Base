import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class CircularDisplay extends StatefulWidget {
  const CircularDisplay({super.key});

  @override
  State<CircularDisplay> createState() => _CircularDisplayState();
}

class _CircularDisplayState extends State<CircularDisplay> {
  final int _duration = 10;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          _button(
            title: "Start",
            onPressed: () => _controller.start(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Pause",
            onPressed: () => _controller.pause(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Resume",
            onPressed: () => _controller.resume(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Restart",
            onPressed: () => _controller.restart(duration: _duration),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("Circular Counter with countdown timer"),
      ),
      body: Center(
        child: CircularCountDownTimer(
          // Countdown duration in Seconds.
          duration: _duration,
          // Countdown initial elapsed Duration in Seconds.
          initialDuration: 0,
          // Controls (i.e., Start, Pause, Resume, Restart) the Countdown Timer.
          controller: _controller,
          // Width of the Countdown Widget.
          width: MediaQuery.of(context).size.width / 2,
          // Height of the Countdown Widget.
          height: MediaQuery.of(context).size.height / 2,
          // Ring Color for Countdown Widget.
          ringColor: Colors.blue,
          // Ring Gradient for Countdown Widget.
          ringGradient: null,
          // Filling Color for Countdown Widget.
          fillColor: Colors.red,
          // Filling Gradient for Countdown Widget.
          fillGradient: null,
          // Background Color for Countdown Widget.
          backgroundColor: Colors.amber,
          // Background Gradient for Countdown Widget.
          backgroundGradient: null,
          // Border Thickness of the Countdown Ring.
          strokeWidth: 20.0,
          // Begin and end contours with a flat edge and no extension.
          strokeCap: StrokeCap.round,
          // Text Style for Countdown Text.
          textStyle: const TextStyle(
            fontSize: 33.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          // Format for the Countdown Text.
          textFormat: CountdownTextFormat.S,
          // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
          isReverse: true,
          // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
          isReverseAnimation: true,
          // Handles visibility of the Countdown Text.
          isTimerTextShown: true,
          // Handles the timer start.
          autoStart: true,
          // This Callback will execute when the Countdown Starts.
          onStart: () {
            // Here, do whatever you want
            debugPrint('Started Countdown');
          },
          // This Callback will execute when the Countdown Ends.
          onComplete: () {
            // Here, do whatever you want
            debugPrint('Ended Countdown');
          },
          // This Callback will execute when the Countdown Changes.
          onChange: (String timeStamp) {
            // Here, do whatever you want
            debugPrint('Changed Countdown $timeStamp');
          },
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            if (duration.inSeconds == 0) {
              // only format for '0'
              return "Start";
            } else {
              // other durations by it's default format
              return Function.apply(defaultFormatterFunction, [duration]);
            }
          },
        ),
      ),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
