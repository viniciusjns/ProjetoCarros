import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros != null ? carros.length : 0,
          itemBuilder: (context, index) {
            Carro c = carros[index];

            return InkWell(
              onTap: () {
                _onClickCarro(context, c);
              },
              onLongPress: () {
                _onLongClickCarro(context, c);
              },
              child: Card(
                color: Colors.grey[100],
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: c.urlFoto ??
                              "https://www.movehostel.com/storage/app/Hostels/875dd630-62a2-11e9-b73e-c39e14307f6e/defaulthostel.png",
                          width: 250,
                        ),
                      ),
                      Text(
                        c.nome ?? "",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "descrição...",
                        style: TextStyle(fontSize: 14),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETALHES'),
                            onPressed: () => _onClickCarro(context, c),
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () {
                              _onClickShare(context, c);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  _onClickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }

  void _onLongClickCarro(BuildContext context, Carro c) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  c.nome,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text("Detalhes"),
                leading: Icon(Icons.directions_car),
                onTap: () {
                  pop(context);
                  _onClickCarro(context, c);
                },
              ),
              ListTile(
                title: Text("Share"),
                leading: Icon(Icons.share),
                onTap: () {
                  pop(context);
                  _onClickShare(context, c);
                },
              ),
            ],
          );
        });
  }

  void _onClickShare(BuildContext context, Carro c) {
    print("Share ${c.nome}");
    Share.share(c.urlFoto);
  }
}
