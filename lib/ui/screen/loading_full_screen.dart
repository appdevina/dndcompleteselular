part of 'screens.dart';

class LoadingFullScreen extends StatelessWidget {
  const LoadingFullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
