import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'movies.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
    // home: details(),
      routes: {
        "/": (_) =>  MyHomePage(),
        "/MoviesScreen": (_) => screen(),
        "/movie-details": (_) => details(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List <Movies>movies=[];
  List <Movies>movies2=[];



  @override
  void initState() {
    getmovies();
    getmovies2();

    super.initState();

  }

  getmovies() async{
    var response= await Dio().get("https://api.themoviedb.org/3/movie/popular",
        queryParameters: {"api_key":"f55fbda0cb73b855629e676e54ab6d8e"});
    //print(response.data["results"]);
    for(int i=0;i<(response.data["results"] as List).length ;i++) {
      Movies movie = new Movies.frommap(response.data["results"][i]);
      movies.add(movie);
    }
    setState(() {});
  }
  getmovies2() async{
    var response= await Dio().get("https://api.themoviedb.org/3/movie/now_playing",
        queryParameters: {"api_key":"f55fbda0cb73b855629e676e54ab6d8e"});
    //print(response.data["results"]);
    for(int i=0;i<(response.data["results"] as List).length ;i++) {
      Movies movie = new Movies.frommap(response.data["results"][i]);
      movies2.add(movie);
    }
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
       centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text("MovieHunt" ,style: TextStyle(color: Colors.blue),),
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blueGrey[900],
            margin: EdgeInsets.only(top: 2,bottom: 2),
            height: 310,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                 Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(" Now playing",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                   Spacer(),
                   GestureDetector(
                     onTap: (){
                      Navigator.pushNamed(context,
                      "/MoviesScreen",
                        arguments: "Now PLaying"
                      );


                     },
                       child: Text("View all",style: TextStyle(color: Colors.blue,fontSize: 12),)
                   ),

                 ],
               ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.all(3),
                    height: 250,
                    width: double.infinity,
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                       shrinkWrap: true,


                       itemCount: movies2.length,
                       itemBuilder: (_,index){
                       Movies movie = movies2[index];
                       return GestureDetector(
                         onTap: (){
                           Navigator.pushNamed(context,"/movie-details",arguments : (movie));
                         },
                         child: Container(
                           margin: EdgeInsets.all(8),
                           height: 200,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start, //in row and column
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Expanded(
                                 child: Container(
                                   clipBehavior: Clip.antiAlias,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   child:
                                   Image.network
                                     (
                                   movie.poster_path.toString(),
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                               ),
                               Expanded(
                                 child: Container(
                                   padding: EdgeInsets.all(8),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(
                                       movie.title.toString(),
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 15,
                                           fontWeight: FontWeight.w800,
                                         ),
                                       ),
                                       SizedBox(height: 5),
                                       Row(
                                         children: [


                                           RatingBar.builder(
                                             itemSize: 12,

                                             initialRating: ((movie.vote_average!).toDouble()/2),
                                             minRating: 1,
                                             direction: Axis.horizontal,
                                             allowHalfRating: true,
                                             itemCount: 5,
                                             itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                             itemBuilder: (context, _) => Icon(

                                               Icons.star
                                               ,
                                               color: Colors.amber,
                                             ),
                                             onRatingUpdate: (rating) {
                                               print(rating);
                                             },
                                           ),

                                           SizedBox(width: 10),
                                           Text(
                                             "${movie.vote_count} reviews",
                                             style: TextStyle(
                                               color: Colors.white,
                                             ),
                                           ),
                                           SizedBox(width: 10),
                                         ],
                                       ),
                                       SizedBox(height: 5),
                                       Row(
                                         children: [
                                           Icon(
                                             Icons.access_time,
                                             size: 14,
                                             color: Colors.grey[350],
                                           ),
                                           SizedBox(width: 4),
                                           Text(
                                             "2h 14m",
                                             style: TextStyle(
                                               color: Colors.grey[350],
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(height: 5),
                                       Row(
                                         children: [
                                           Icon(
                                             Icons.access_time,
                                             size: 14,
                                             color: Colors.grey[350],
                                           ),
                                           SizedBox(width: 4),
                                           Text(
                                             "2019/12/31",
                                             style: TextStyle(
                                               color: Colors.grey[350],
                                             ),
                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                 ),
                               )
                             ],
                           ),
                         ),
                       );

                       }


                   ),

                  ),


                ],
              ),

          ),
          SizedBox(height: 10),
          Container(
            color: Colors.blueGrey[900],
            margin: EdgeInsets.only(top: 2,bottom: 2),
            height: 310,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Popular",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    Spacer(),
                    GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(
                              context,
                              "/MoviesScreen",
                              arguments: "Popular"
                          );


                        },
                        child: Text("View all",style: TextStyle(color: Colors.blue,fontSize: 12),)
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.all(3),
                  height: 250,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,


                      itemCount: movies.length,
                      itemBuilder: (_,index){
                        Movies movie = movies[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context,"/movie-details",arguments : (movie));
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start, //in row and column
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                    Image.network
                                      (
                                      movie.poster_path.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [


                                            RatingBar.builder(
                                              itemSize: 12,

                                              initialRating: ((movie.vote_average!).toDouble()/2),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(

                                                Icons.star
                                                ,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),

                                            SizedBox(width: 10),
                                            Text(
                                              "${movie.vote_count} reviews",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Colors.grey[350],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "2h 14m",
                                              style: TextStyle(
                                                color: Colors.grey[350],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Colors.grey[350],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "2019/12/31",
                                              style: TextStyle(
                                                color: Colors.grey[350],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );

                      }


                  ),

                ),


              ],
            ),

          ),
        ],
      ),
    );
  }
}

class screen extends StatefulWidget{
  @override
  _screenstate createState() =>_screenstate();
}


class _screenstate extends State<screen>{
  List <Movies>movies=[];
  String ? statue;
  String ? s;
  _screenstate({this.statue});



  @override
  void initState() {
Future.delayed(Duration.zero,()=>getmovies());


    super.initState();

  }

  getmovies() async{
    statue = ModalRoute.of(context)?.settings.arguments as String?;
    if(statue=="Popular") {
    s="popular";
    }else if(statue=="Now Playing"){
    s="now_playing";

    }
    var response= await Dio().get("https://api.themoviedb.org/3/movie/"+s!,
        queryParameters: {"api_key":"f55fbda0cb73b855629e676e54ab6d8e"});
    //print(response.data["results"]);
    for(int i=0;i<(response.data["results"] as List).length ;i++) {
      Movies movie = new Movies.frommap(response.data["results"][i]);
      movies.add(movie);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    statue = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: Text(statue! ,style: TextStyle(color: Colors.blue),),
      ),
      backgroundColor: Colors.blueGrey[900],
      body:

      Container(
            color: Colors.blueGrey[900],





                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,


                      itemCount: movies.length,
                      itemBuilder: (_,index){
                        Movies movie = movies[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context,"/movie-details",arguments : (movie));
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start, //in row and column
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                    Image.network
                                      (
                                      movie.poster_path.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [


                                            RatingBar.builder(
                                              itemSize: 12,

                                              initialRating: ((movie.vote_average!).toDouble()/2),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(

                                                Icons.star
                                                ,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),

                                            SizedBox(width: 10),
                                            Text(
                                              "${movie.vote_count} reviews",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Colors.grey[350],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "2h 14m",
                                              style: TextStyle(
                                                color: Colors.grey[350],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Colors.grey[350],
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "2019/12/31",
                                              style: TextStyle(
                                                color: Colors.grey[350],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );

                      }


                  ),

                ),





          );





  }}

class details extends StatefulWidget{
  @override
  _detailstate createState() =>_detailstate();

}

class _detailstate extends State<details>{
  List <Movies>movies=[];
  Movies? movie;
  @override
  void initState() {



    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(350),
        child: AppBar(
          flexibleSpace: ClipRRect(
            // borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50)),
            child: Container (decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(movie!.poster_path.toString())),




            ),
            ),
          ),
          backgroundColor: Colors.transparent,
          // shape: RoundedRectangleBorder(
          //  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))
          //   ),
        ),

      ),





      body: Container(
        child: Container(
          height: 700,
          margin: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie!.title.toString()
                        ,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [


                          RatingBar.builder(
                            itemSize: 12,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(

                              Icons.star
                              ,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),

                          SizedBox(width: 10),
                          Text(
                            "${movie!.vote_count!/1000}k reviews",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey[350],
                          ),
                          SizedBox(width: 4),
                          Text(
                            "3h ",
                            style: TextStyle(
                              color: Colors.grey[350],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey[350],
                          ),
                          SizedBox(width: 4),
                          Text(
                            "2020/12/30",
                            style: TextStyle(
                              color: Colors.grey[350],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(movie!.overview.toString()
                        ,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,

                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
