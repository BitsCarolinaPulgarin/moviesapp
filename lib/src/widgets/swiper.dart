import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_app/src/models/pelicula.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});


  @override
  Widget build(BuildContext context) {

    final _screeSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child:  Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screeSize.width * 0.7,
        itemHeight: _screeSize.height *0.5,
        itemBuilder: (BuildContext context,int index){
          peliculas[index].uniqueId = '${peliculas[index].id}-poster';
          return Hero(
              tag: peliculas[index].uniqueId,
              child:ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    onTap: ()=>Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                      child: FadeInImage(
                        image: NetworkImage( peliculas[index].getPostImg() ),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                      )
                  )
              )
          );

        },
        itemCount: peliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
