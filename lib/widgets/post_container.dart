import 'package:flutter/material.dart';
import 'package:manoo/constant/color.dart';
import 'package:manoo/constant/text_style.dart';



class PostContainer extends StatefulWidget {

  final snap;

  const PostContainer({Key? key, required this.snap})
      : super(key: key);
  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {



  @override
  Widget build(BuildContext context) {

    String? image = widget.snap['profilePicture'].toString();

    if (widget.snap['profilePicture'].toString().isEmpty) {
      setState(() {
        image = "https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png";
      });

    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                NetworkImage(image!),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Text(
                    widget.snap['userName'].toString(),
                    style: style2
                  ),
                  Text(
                    "  @${widget.snap['nickName'].toString()}",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                  ),

                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text(
              widget.snap['text'].toString() ,
              style: style3
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(
              children: [
                const SizedBox(height: 15),
                widget.snap['image'] == null ?
                    const Center()
                :Container(
                  height: 250,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.snap['image'].toString()),
                      )),
                )


              ],
            ),
          ),
          const SizedBox(height: 15),
          const SizedBox(height: 10),
          const Divider()
        ],
      ),
    );
  }
}