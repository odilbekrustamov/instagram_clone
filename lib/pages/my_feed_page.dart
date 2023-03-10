import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/post_model.dart';

class MyFeedPage extends StatefulWidget {
  static final String id = "myfeed_page";
  final PageController? pageController;
  const MyFeedPage({Key? key, this.pageController}): super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  bool isLoading = false;
  List<Post> items = [];

  String image_1 = "https://images.unsplash.com/photo-1561924563-d9ad0f32b23f";
  String image_2 = "https://i.pinimg.com/564x/bd/13/af/bd13af840b16653e09ca8d2fdba4d98f.jpg";
  String image_3 = "https://images.unsplash.com/photo-1532974297617-c0f05fe48bff";

  @override
  void initState() {
    super.initState();
    items.add(Post(image_1, "-Audi is the ultimate example of dynamics, sportiness, and energy."));
    items.add(Post(image_2, "The new Audi A8 is more advanced and complex than a brain surgeon’s tools, making life easier. Visit us now to schedule your test drive!"));
    items.add(Post(image_3, "Everyone’s got a story. But we all live on the same planet. why not keep it clean? I don’t just love #audi. I live it."));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
              "Instagram",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
          ),
          actions: [
            IconButton(
                onPressed: (){
                  widget.pageController!.animateToPage(
                      2, duration: Duration(microseconds: 200),
                      curve: Curves.easeIn);
                },
                icon: Icon(Icons.camera_alt, color: Color.fromRGBO(193, 53, 132, 1),)
            )
          ],
        ),
        body:Stack(
          children: [
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index){
                return _itemOfPost(items[index]);
              },
            ),

            //#loading
            isLoading? Center(
              child: CircularProgressIndicator(),
            )
                :SizedBox.shrink()
          ],
        )
    );
  }

  Widget _itemOfPost(Post post){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Divider(),

          //  #user info
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image(
                        image: AssetImage("assets/images/ic_person.png"),
                        width: 40,
                        height: 40,
                      ),
                    ),

                    SizedBox(width: 10,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rustamov Odilbek", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),

                        SizedBox(height: 3,),

                        Text("2023-03-10 15:33", style: TextStyle(fontWeight: FontWeight.normal),)
                      ],
                    )
                  ],
                ),

                IconButton(
                    onPressed: (){

                    },
                    icon: Icon(Icons.more_horiz)
                )
              ],
            ),
          ),

          // #post image
          SizedBox(height: 8,),

          CachedNetworkImage(
            imageUrl: post.img_post,
            placeholder: (context, url) => Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Center(
                 child: Icon(Icons.error, color: Colors.red,)
              ),
            ),
            fit: BoxFit.cover,
          ),

          // #like share
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(
                        EvaIcons.heart,
                        color: Colors.red,
                      )
                  ),

                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(
                        EvaIcons.messageCircleOutline,
                        color: Colors.black,
                      )
                  ),

                  IconButton(
                      onPressed: (){

                      },
                      icon: Icon(
                        EvaIcons.paperPlaneOutline,
                        color: Colors.black,
                      )
                  )
                ],
              )
            ],
          ),

          // #caption
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                text: "${post.caption}",
                style: TextStyle(color: Colors.black)
              ),
            ),
          )
        ],
      ),
    );
  }
}
