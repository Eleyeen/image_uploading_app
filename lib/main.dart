import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_uploading_app/screen/albumPage.dart';
import 'package:image_uploading_app/screen/grideView.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Album>? _albums;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('All gallery Folders'),
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  double gridWidth = (constraints.maxWidth - 20) / 3;
                  double gridHeight = gridWidth + 33;
                  double ratio = gridWidth / gridHeight;
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: GridView.count(
                      childAspectRatio: ratio,
                      crossAxisCount: 3,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      children: <Widget>[
                        ...?_albums?.map(
                          (album) => GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => AlbumPage(album))),
                            child: Stack(
                              children: [
                                Column(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Container(
                                        color: Colors.grey[300],
                                        height: 100,
                                        width: 100,
                                        child: FadeInImage(
                                          fit: BoxFit.cover,
                                          placeholder:
                                              MemoryImage(kTransparentImage),
                                          image: AlbumThumbnailProvider(
                                            albumId: album.id,
                                            mediumType: album.mediumType,
                                            highQuality: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 2.0),
                                      child: Text(
                                        album.name,
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          height: 1.2,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 2.0),
                                      child: Text(
                                        album.count.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          height: 1.2,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Positioned(
                                //   top: 3,
                                //   left: 105,
                                //   child: Container(
                                //     width: 20,
                                //     height: 20,
                                //     child: Icon(
                                //       Icons.check_circle_rounded,
                                //       color: Colors.yellow,
                                //     ),
                                //   ),
                                // ), //
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
