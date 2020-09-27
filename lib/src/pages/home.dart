import 'package:flutter/material.dart';
import 'package:peliculas_app/src/search/search_delegate.dart';
import 'package:peliculas_app/src/services/peliculas.dart';
import 'package:peliculas_app/src/widgets/movies_horizontal.dart';
import '../widgets/swiper.dart';

class Home extends StatelessWidget {

  PeliculasServices peliculas = new PeliculasServices();

  @override
  Widget build(BuildContext context) {

    peliculas.getPopulares();

    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 20, 20, 1.0),
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon:  Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      )
    );
  }

  Widget  _swiperTarjetas (){

    return FutureBuilder(
      future: peliculas.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        }else{
          return Container(
            height: 300.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context){

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Populares',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculas.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){

              if(snapshot.hasData){
                return MoviesHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina: peliculas.getPopulares,
                );
              }else{
                return Center(
                    child: CircularProgressIndicator(),
                );
              }
            }
          )

        ],
      ),
    );
  }



}
