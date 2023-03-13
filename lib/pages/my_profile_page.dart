import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/post_model.dart';

class MyProfilePage extends StatefulWidget {
  static final String id = "myprofile_page";

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool isLoading = false;
  int axisCount = 1;
  List<Post> items = [];
  String fullname = "Odilbek Rustamov", email = "odilbekrustamov1215@gmail.com", img_url = "";
  final ImagePicker _picker = ImagePicker();
  File? _image;
  int count_posts = 0, count_followers = 0, count_following = 0;

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

  _imgFromGallary()async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromCamers()async{
    XFile? image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Profile",
            style: TextStyle(
                color: Colors.black, fontFamily: "Billabong", fontSize: 25),
          ),
          actions: [
            IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.exit_to_app),
              color: Color.fromRGBO(193, 53, 132, 1),
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  //#myphoto
                  GestureDetector(
                      onTap: () {
                        _settingModalBottomSheet(context);
                      },
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              border: Border.all(
                                width: 1.5,
                                color: Color.fromRGBO(193, 53, 132, 1),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: _image == null
                                  ? Image(
                                image: AssetImage(
                                    "assets/images/ic_person.png"),
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              )
                                  : Image.file(
                                _image!,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  color: Colors.purple,
                                )
                              ],
                            ),
                          ),
                        ],
                      )),

                  //#myinfos
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    fullname.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),

                  //#mycounts
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  count_posts.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "POSTS",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  count_followers.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "FOLLOWERS",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  count_following.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "FOLLOWING",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //list or grid
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  axisCount = 1;
                                });
                              },
                              icon: Icon(Icons.list_alt),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  axisCount = 2;
                                });
                              },
                              icon: Icon(Icons.grid_view),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //#myposts
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: axisCount),
                      itemCount: items.length,
                      itemBuilder: (ctx, index) {
                        return _itemOfPost(items[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _itemOfPost(Post post){
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              width: double.infinity,
              imageUrl: post.img_post,
              placeholder: (contex, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, errorr) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 3,),
          Text(
            post.caption,
            style: TextStyle(color: Colors.black87.withOpacity(0.7)),
            maxLines: 2,
          )
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Pick Photo'),
                    onTap: () => {
                      _imgFromGallary(),
                      Navigator.pop(context)
                    }
                ),
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('Take Photo'),
                  onTap: () => {
                    _imgFromCamers(),
                    Navigator.pop(context)
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}
