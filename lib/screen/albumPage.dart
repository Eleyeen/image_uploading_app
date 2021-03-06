import 'package:flutter/material.dart';
import 'package:image_uploading_app/screen/grideView.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';



String indexvalue ="";
class AlbumPage extends StatefulWidget {
  final Album album;

  AlbumPage(Album album) : album = album;

  @override
  State<StatefulWidget> createState() => AlbumPageState();
}

class AlbumPageState extends State<AlbumPage> {
  List<Medium>? _media;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }

  int _imageNum = 1;
  bool _check = false;
  bool change = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.album.name),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: <Widget>[
            ...?_media?.map(
              (medium) => GestureDetector(
                onTap: () {
                   indexvalue = medium.id.toString();
                  setState(() {
                    print(medium.id);
                    change = true ;
                    

                  });
                },
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => ViewerPage(medium))),

                // child:  GrideView(mediumId: medium.id,mediumType: medium.mediumType,)
                child:
                 change ==false ?
                    
                     Container(
                  color: Colors.grey[300],
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: MemoryImage(kTransparentImage),
                    image: ThumbnailProvider(
                      mediumId: medium.id,
                      mediumType: medium.mediumType,
                      highQuality: true,
                    ),
                  ),
                )
                :
                GrideView(mediumId: medium.id,mediumType: medium.mediumType,)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
