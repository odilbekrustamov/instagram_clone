import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/model/post_model.dart';
import 'package:instagram_clone/service/file_service.dart';

import '../service/db_service.dart';

class MyUploadPage extends StatefulWidget {
  static final String id = "myupload_page";
  final PageController? pageController;
  const MyUploadPage({Key? key, this.pageController}): super(key: key);

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  bool isLoading = false;
  var captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  _uploadNewPost(){
    String caption = captionController.text.toString();
    if(caption.isEmpty) return;
    if(_image == null) return;

    _apiPostImage();
  }

  void _apiPostImage(){
    setState(() {
      isLoading = true
      ;
    });
    FileService.uploadUserImage(_image!).then((downloadUrl) => {
      _resPostImage(downloadUrl),
    });
  }

  void _resPostImage(String downloadUrl){
    String caption = captionController.text.toString();
    Post post = Post(caption, downloadUrl);
    _apiStorePost(post);
  }

  void _apiStorePost(Post post)async{
    // Post to posts
    Post posted = await DBService.storePost(post);
    //Post to feeds
    DBService.storeFeed(posted).then((value) => {
      _moveToFeed(),
    });
  }

  _moveToFeed(){
    setState(() {
      isLoading = false;
    });
    captionController.text = "";
    _image = null;
    widget.pageController!.animateToPage(
        0, duration: Duration(microseconds: 200),
        curve: Curves.easeIn);
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
          title: Text("Upload", style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(
                onPressed: (){
                  _uploadNewPost();
                },
                icon: Icon(
                  Icons.drive_folder_upload,
                  color: Color.fromRGBO(193, 53, 132, 1),
                ))
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    //#add photo
                    GestureDetector(
                      onTap: (){
                       // _imgFromGallary();
                        _settingModalBottomSheet(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width,
                        color: Colors.grey.withOpacity(0.4),
                        child: _image == null
                            ? Center(
                               child: Icon(
                                 Icons.add_a_photo,
                                 size: 50,
                                 color: Colors.grey,
                               )
                             )
                            :Stack(
                          children: [
                            Image.file(_image!,
                                 fit: BoxFit.cover ,
                                 width: double.infinity,
                                 height: double.infinity,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.black12,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        setState(() {
                                          _image = null;
                                        });
                                      },
                                      icon: Icon(Icons.highlight_remove),
                                       color: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ),
                    ),

                    // #caption text
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: TextField(
                        controller: captionController,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Caption",
                          hintStyle:
                            TextStyle(fontSize: 17, color: Colors.black38)
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
