import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';


class GrideView extends StatefulWidget {
  var mediumId;
  MediumType? mediumType;

  GrideView({Key? key, this.mediumId, this.mediumType});

  @override
  _GrideViewState createState() => _GrideViewState();
}

class _GrideViewState extends State<GrideView> {
  int _imageNum = 0;
  bool _check = false;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 5),
      child: Container(
        height: 130,
        width: 120,
        child: Stack(
          children: [
            Container(
              width: 130,
              height: 120,
              color: Colors.grey[300],
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: ThumbnailProvider(
                  mediumId: widget.mediumId,
                  mediumType: widget.mediumType,
                  highQuality: true,

                ),
              ),
            ),
            Positioned(
              top: 1,
              left: 75,
              child: Container(
                width: 50,
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: Text(_imageNum.toString()),
                  onPressed: () {},
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 2,
              child: Container(
                  child: Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _imageNum--;
                          print(_imageNum);
                        });
                      },
                      icon: Icon(Icons.remove_circle, color: Color(0xff8149aa))),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    _imageNum.toString(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff8149aa),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _imageNum++;
                          print(_imageNum);
                        });
                      },
                      icon: Icon(Icons.add_circle, color: Color(0xff8149aa)))
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
