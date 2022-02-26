import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controllers/comment_controller.dart';
import 'package:flutter_firebase_blog/controllers/like_controller.dart';
import 'package:flutter_firebase_blog/controllers/post_controller.dart';
import 'package:flutter_firebase_blog/controllers/user_controller.dart';
import 'package:flutter_firebase_blog/helpers/constants.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';
import 'package:flutter_firebase_blog/models/client.dart';
import 'package:flutter_firebase_blog/models/comment.dart';
import 'package:flutter_firebase_blog/models/like.dart';
import 'package:flutter_firebase_blog/models/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shimmer/shimmer.dart';

class PostActivity extends StatefulWidget {
  Post? post;
  Client? client;
  PostActivity({Key? key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostActivityState();
}

class _PostActivityState extends State<PostActivity> {
  bool _showBackToTopButton = false;

  ScrollController _scrollController = ScrollController();
  final TextEditingController _comment = TextEditingController();

  final UserController _userController = UserController();
  final PostController _postController = PostController();
  final CommentController _commentController = CommentController();
  final LikeController _likeController = LikeController();

  var postId;
  var userId;

  String likeId = '';

  int totalLikes = 0;
  int totalViews = 0;
  int totalComments = 0;

  var focusComment = FocusNode();

  var _initialize;

  initializer() async {
    await _userController.getUser().then((value) {
      widget.client = value;
    });
  }

  @override
  void initState() {
    _initialize = initializer();
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 70) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width;

    totalLikes = widget.post!.likes?.length ?? 0;
    totalViews = widget.post!.views;
    totalComments = widget.post!.comments?.length ?? 0;

    return FutureBuilder(
      future: _initialize,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Shimmer(
                  gradient: const LinearGradient(
                    colors: [Colors.white70, Colors.white, Colors.white30],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Container(
                            width: double.infinity,
                            height: 20,
                            color: Colors.white),
                        const SizedBox(height: 10),
                        Container(
                            width: double.infinity,
                            height: 20,
                            color: Colors.white),
                        const SizedBox(height: 10),
                        ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 0, right: 0),
                          leading: Container(
                              width: 48, height: 48, color: Colors.white),
                          title: Container(
                              width: double.infinity,
                              height: 15,
                              color: Colors.white),
                          subtitle: Container(
                              width: 60, height: 15, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: 0, right: 0),
                                    leading: Container(
                                        width: 48,
                                        height: 48,
                                        color: Colors.white),
                                    title: Container(
                                        width: double.infinity,
                                        height: 15,
                                        color: Colors.white),
                                    subtitle: Container(
                                        width: 60,
                                        height: 15,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    width: 65,
                                    height: 200,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          String _cover = widget.post!.cover ??
              constants['images']['base_path'] +
                  constants['images']['cover']['landscape'];
          var username =
              '${widget.post?.client!.firstName} ${widget.post?.client!.lastName}';

          userId = '${widget.client?.id}';
          postId = '${widget.post?.id}';

          var l = widget.post?.likes!
              .where((row) => (row.userId!.contains(userId)));
          /*{
                  if (row.userId!.contains(userId)) {
                    _like = row;
                    return true;
                  }return false;
                }*/ /*=> (row.userId!.contains(userId))*/
          Like? like = Like();
          if (l!.toList().isNotEmpty) {
            like = l.toList().first;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(formattedTitle(widget.post?.title as String)),
              centerTitle: true,
              /*actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: const [
                          Icon(Icons.edit),
                          SizedBox(width: 2),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: const [
                          FaIcon(FontAwesomeIcons.trash),
                          SizedBox(width: 2),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    print(value);
                  },
                )
              ],*/
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Ink.image(
                        image: AssetImage(_cover),
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: 5,
                        right: 5,
                        bottom: 10,
                        child: Card(
                          elevation: 1,
                          child: Container(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, .7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('$totalLikes Likes',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )),
                                Text('$totalViews Views',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )),
                                Text('$totalComments Comments',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, bottom: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post?.title ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                          softWrap: true,
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 0),
                          leading: CircleAvatar(
                              backgroundImage:
                                  (widget.post?.client!.avatar != null)
                                      ? NetworkImage(
                                          widget.post?.client!.avatar as String)
                                      : null),
                          title: Text(username),
                          subtitle: Text(formattedDate(
                              widget.post?.createdOn as DateTime)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Html(
                          data: widget.post?.content,
                          tagsList: Html.tags..addAll(["bird", "flutter"]),
                          style: {
                            "table": Style(
                              backgroundColor:
                                  const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                            ),
                            "tr": Style(
                              border: const Border(
                                  bottom: BorderSide(color: Colors.grey)),
                            ),
                            "th": Style(
                              padding: const EdgeInsets.all(6),
                              backgroundColor: Colors.grey,
                            ),
                            "td": Style(
                              padding: const EdgeInsets.all(6),
                              alignment: Alignment.topLeft,
                            ),
                            'h5': Style(
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis),
                          },
                          customRender: {
                            "table": (context, child) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: (context.tree as TableLayoutElement)
                                    .toWidget(context),
                              );
                            },
                            "bird": (RenderContext context, Widget child) {
                              return const TextSpan(text: "🐦");
                            },
                            "flutter": (RenderContext context, Widget child) {
                              return FlutterLogo(
                                style: (context.tree.element!
                                            .attributes['horizontal'] !=
                                        null)
                                    ? FlutterLogoStyle.horizontal
                                    : FlutterLogoStyle.markOnly,
                                textColor: context.style.color!,
                                size: context.style.fontSize!.size! * 5,
                              );
                            },
                          },
                          customImageRenders: {
                            networkSourceMatcher(domains: ["flutter.dev"]):
                                (context, attributes, element) {
                              return const FlutterLogo(size: 36);
                            },
                            networkSourceMatcher(domains: ["domain.com"]):
                                networkImageRender(
                              headers: {"Custom-Header": "some-value"},
                              altWidget: (alt) => Text(alt ?? ""),
                              loadingWidget: () => const Text("Loading..."),
                            ),
                            // On relative paths starting with /wiki, prefix with a base url
                            (attr, _) =>
                                    attr["src"] != null &&
                                    attr["src"]!.startsWith("/wiki"):
                                networkImageRender(
                                    mapUrl: (url) =>
                                        "https://upload.wikimedia.org" + url!),
                            // Custom placeholder image for broken links
                            networkSourceMatcher(): networkImageRender(
                                altWidget: (_) => const FlutterLogo()),
                          },
                          onLinkTap: (url, _, __, ___) =>
                              print("Opening $url..."),
                          onImageTap: (src, _, __, ___) => print(src),
                          onImageError: (exception, stackTrace) =>
                              print(exception),
                          onCssParseError: (css, messages) {
                            print("css that error: $css");
                            print("error messages:");
                            messages.forEach((element) => print(element));
                          },
                        ),
                        const Divider(),
                        const Text('Comments',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Comment',
                                ),
                                focusNode: focusComment,
                                minLines: 5,
                                maxLines: 10,
                                controller: _comment,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    Comment create = Comment(
                                        userId: userId,
                                        postId: postId,
                                        comment: _comment.text,
                                        createdOn: DateTime.now(),
                                        client: widget.client);
                                    await _commentController
                                        .create(create.dataModel)
                                        .then((value) {
                                      if (value['status'] == true) {
                                        toast(value['message']);
                                        create.id = value['id'];
                                        _comment.text = '';
                                        widget.post?.comments!.add(create);
                                        /*widget.post?.comments!.sort((a, b) =>
                                            (a.createdOn as DateTime).compareTo(
                                                (b.createdOn as DateTime)));*/
                                        FocusScope.of(context).unfocus();
                                        _comment.clear();

                                        setState(() {});
                                      }
                                    });
                                  },
                                  child: const SizedBox(
                                      width: double.infinity,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text('Comment'),
                                      )))
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: widget.post?.comments?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var commenter =
                                '${widget.post?.comments![index].client?.firstName} ${widget.post?.comments![index].client?.lastName}';
                            return Card(
                              elevation: 1,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundImage: (widget
                                                    .post
                                                    ?.comments![index]
                                                    .client!
                                                    .avatar !=
                                                null)
                                            ? NetworkImage(widget
                                                .post
                                                ?.comments![index]
                                                .client!
                                                .avatar as String)
                                            : null),
                                    title: Text(commenter),
                                    subtitle: Text(formattedDate(widget
                                        .post
                                        ?.comments![index]
                                        .createdOn as DateTime)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(widget.post?.comments![index]
                                          .comment as String),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 15,
                  bottom: 10,
                  child: FloatingActionButton(
                    //heroTag: 'like',
                    onPressed: () async {
                      Like create = Like(userId: userId, postId: postId);
                      if (likeId.isNotEmpty) {
                        await _likeController.delete(likeId).then((value) {
                          setState(() {
                            likeId = '';
                            totalLikes--;
                          });
                        });
                      } else {
                        await _likeController
                            .create(create.dataModel)
                            .then((value) {
                          if (value['status'] == true) {
                            toast(value['message']);
                            setState(() {
                              create.id = value['id'];
                              //like = create;
                              likeId = value['id'];
                              totalLikes++;
                            });
                          }
                        });
                      }
                    },
                    child: (likeId.isNotEmpty)
                        ? const FaIcon(
                            FontAwesomeIcons.solidThumbsUp,
                            size: 20,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.thumbsUp,
                            size: 20,
                          ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 30,
                  bottom: 10,
                  child: _showBackToTopButton == false
                      ? Container()
                      : FloatingActionButton(
                          //heroTag: 'top',
                          onPressed: _scrollToTop,
                          child: const FaIcon(
                            FontAwesomeIcons.arrowUp,
                            size: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                ),
                Positioned(
                  bottom: 10,
                  right: 15,
                  child: FloatingActionButton(
                    //heroTag: 'comment',
                    onPressed: () {
                      focusComment.requestFocus();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.comment,
                      size: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                // Add more floating buttons if you want
                // There is no limit
              ],
            ),
            //bottomNavigationBar: bottomBar(context),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
