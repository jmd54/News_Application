import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application/models/categories_news_model.dart';
import 'package:news_application/view_model/news_view_model.dart';

class category_screen extends StatefulWidget {
  const category_screen({super.key});

  @override
  State<category_screen> createState() => _category_screenState();
}

class _category_screenState extends State<category_screen> {

  final format = DateFormat('MMMM dd, yyyy');

  String categoryName="General";
   List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;
    
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10,),
            SizedBox(height: 30,
            child:  ListView.builder(
              itemCount: categoriesList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  categoryName=categoriesList[index];
                  setState(() {
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: categoryName==categoriesList[index]?Colors.orange:Colors.blue,
                      ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(categoriesList[index],style: TextStyle(fontSize: 13, color: Colors.white),),
                    ),
                  ),
                ),
              );
            },),
            ),
            SizedBox(height: 50,),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: NewsViewModel().fetchCategoriesNewsApi(categoryName),
                builder: (BuildContext context, snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context , index){

                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height: height * .18,
                                    width: width * .3,
                                    placeholder:  (context , url) => Container(child: Center(
                                      child: SpinKitCircle(
                                        size: 50,
                                        color: Colors.blue,
                                      ),
                                    ),),
                                    errorWidget: (context, url  ,error) => Icon(Icons.error_outline ,color: Colors.red,),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height:  height * .18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!.articles![index].title.toString() ,
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15 ,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.articles![index].source!.name.toString() ,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14 ,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            Text(format.format(dateTime) ,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15 ,
                                                  fontWeight: FontWeight.w500
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
                          );
                        }
                    ) ;
                  }


                    
                },)
              )
          ],
        ),
      ),
    );
  }
}