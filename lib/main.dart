import 'package:flutter/material.dart';
import 'detail.dart';
import 'Tambah.dart';

class Catatan {
  final String judul;
  final String isi;

  Catatan({required this.judul, required this.isi});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<Catatan> daftarCatatan = [];

class _HomePageState extends State<HomePage> {
  void deleteNote(Catatan catatan) {
    daftarCatatan.remove(catatan);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan Saya'),
      ),
      body: ListView.builder(
        itemCount: daftarCatatan.length,
        itemBuilder: (context, index) {
          return MyListItem(
            catatan: daftarCatatan[index],
            onDelete: () => deleteNote(daftarCatatan[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahCatatanPage(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyListItem extends StatefulWidget {
  final Catatan catatan;
  final VoidCallback onDelete;

  MyListItem({required this.catatan, required this.onDelete});

  @override
  _MyListItemState createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: ListTile(
        title: Text(
          widget.catatan.judul,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.catatan.isi),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                catatan: widget.catatan,
                onDelete: widget.onDelete,
              ),
            ),
          );
        },
      ),
    );
  }
}
