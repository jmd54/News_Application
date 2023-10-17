import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application/models/news_headline_model.dart';
import 'package:news_application/view/category.dart';
import 'package:news_application/view_model/news_view_model.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

enum FilterList{thetimesofindia,alaZeeraEnglish}
class _home_screenState extends State<home_screen> {
  
  NewsViewModel newsViewModel= NewsViewModel();
  final format=DateFormat("dd MMMM, yyyy");
  String name="al-jazeera-english";
  FilterList?seletedMenu; 
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => category_screen()));
          },
          icon: Image.asset("images/category.png",fit:BoxFit.cover ,height: 30,width: 30,)
          ),
        title: Center(child: Text("News",style: GoogleFonts.poppins(color: Colors.black, fontSize: 24,fontWeight: FontWeight.w700),)),
        actions: [
          PopupMenuButton<FilterList>(
             initialValue: seletedMenu,
             icon: Icon(Icons.more_vert,color: Colors.black,),
             onSelected: (FilterList item){
              if(FilterList.thetimesofindia.name==item.name){
              name='the-times-of-india';
              }
              if(FilterList.alaZeeraEnglish.name==item.name){
              name='al-jazeera-english';
              }
              
              setState(() {
                
              });
             },

            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
            PopupMenuItem<FilterList>(
              value: FilterList.thetimesofindia,
              child:Text("the-times-of-india"),
              ),
              PopupMenuItem<FilterList>(
              value: FilterList.alaZeeraEnglish,
              child:Text("al-jazeera-english"),
              ),
          ])
    ]
      ),
      body: ListView(
        children: [
          SizedBox(height: height*.55,width: width,
          child: FutureBuilder<news_headline_model>(
            future: newsViewModel.fetchNewsChannelApi(name),
            
            builder: (BuildContext context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(
                  child: SpinKitCircle(size: 50, color: Colors.blue),
                );
                }
                {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                       DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                       return Stack(
                        alignment: Alignment.center,
                         children: [
                           Container(
                            height: 0.6*height,
                            width: .9*width,
                            padding: EdgeInsets.symmetric(horizontal: height*.02,vertical: width*.02),
                             child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                               child: CachedNetworkImage(imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                               fit: BoxFit.cover,
                               placeholder:(context, url) => Container(child: spinKit2,),
                               errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red,),
                               ),    
                               
                             ),
                           ), 
                           Positioned(
                            bottom: 15,
                             child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:  BorderRadius.circular(12),
                              ),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                height: height*0.2,
                                child: Column(
                                  children: [
                                    Container(
                                      width: width*0.7,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot.data!.articles![index].title.toString(),maxLines: 3,overflow: TextOverflow.ellipsis ,style: TextStyle(
                                          fontSize: 17,fontWeight: FontWeight.w700,),),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: width*.7,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data!.articles![index].source!.name.toString(),overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize:16 ,fontWeight: FontWeight.w700),),
                                        Text(format.format(dateTime),overflow: TextOverflow.ellipsis ,style: TextStyle(fontSize:11 ,fontWeight: FontWeight.w500),)
                                      ],
                                    ),)
                                  ],
                           
                                ),
                              ),
                             ),
                           )

                         ],
                       );
                
                     },
                  );
                  }
              },)
            ),   
            
      
        ],
      )
    );
  }

}

const spinKit2=SpinKitFadingCircle(color: Colors.amber,size: 50,);