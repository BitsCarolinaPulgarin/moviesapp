import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula.dart';

class MoviesHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MoviesHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _sreen = MediaQuery.of(context).size;


    _pageController.addListener( (){

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent -200){
        siguientePagina();
      }
    });

    return Container(
      height: _sreen.height *0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (contentx, i){
            return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = '${pelicula.id}-tarjeta';
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPostImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 12) ,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: (){
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}
