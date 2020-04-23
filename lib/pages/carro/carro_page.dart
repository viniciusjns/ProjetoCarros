import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/carro_form_page.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/loremipsum_api.dart';
import 'package:carros/pages/carro/mapa_page.dart';
import 'package:carros/pages/carro/video_page.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'carro.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loremipsumBloc = LoremipsumBloc();

  Color color = Colors.grey;

  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();
    FavoritoService().isFavorito(carro).then((favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });
    _loremipsumBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () {
              _onClickMapa(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              _onClickVideo(context);
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopupMenu(value),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text("Deletar"),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text("Share"),
                ),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: carro.urlFoto ??
                "https://www.movehostel.com/storage/app/Hostels/875dd630-62a2-11e9-b73e-c39e14307f6e/defaulthostel.png",
          ),
          _bloco1(),
          Divider(),
          _bloco2()
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(widget.carro.nome, fontSize: 20, bold: true),
            text(
              widget.carro.tipo,
              fontSize: 16,
            )
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                _onClickShare(carro);
              },
            ),
          ],
        )
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(widget.carro.descricao, fontSize: 16),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
          stream: _loremipsumBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return text(snapshot.data, fontSize: 16);
          },
        ),
      ],
    );
  }

  void _onClickMapa(context) {
    if (carro.latitude != null && carro.longitude != null) {
      push(context, MapaPage(carro));
    } else {
      alert(context, "Este carro não possui nenhuma lat/long");
    }
  }

  void _onClickVideo(BuildContext context) {
    if (carro.urlVideo != null && carro.urlVideo.isNotEmpty) {
//      launch(carro.urlVideo);
      push(context, VideoPage(carro));
    } else {
      alert(context, "Este carro não possui nenhum vídeo");
    }
  }

  void _onClickShare(Carro carro) {
    Share.share(carro.urlFoto);
  }

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        push(context, CarroFormPage(carro: carro));
        break;
      case "Deletar":
        _deletar();
        break;
      case "Share":
        _onClickShare(carro);
        break;
    }
  }

  void _onClickFavorito() async {
    bool favorito = await FavoritoService().favoritar(carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  void _deletar() async {
    ApiResponse<bool> response = await CarrosApi.delete(carro);

    if (response.ok) {
      alert(context, "Carro deletado com sucesso", callback: () {
        EventBus.get(context)
            .sendEvent(CarroEvent("carro_deletado", carro.tipo));

        pop(context);
      });
    } else {
      alert(context, response.msg);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _loremipsumBloc.dispose();
  }
}
