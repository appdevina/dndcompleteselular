part of 'screens.dart';

class DetailFoto extends StatelessWidget {
  final String foto;
  const DetailFoto({Key? key, required this.foto}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.network(
            baseStorage + foto,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
