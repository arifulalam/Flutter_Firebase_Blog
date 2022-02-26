import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog/controllers/post_controller.dart';
import 'package:flutter_firebase_blog/controllers/user_controller.dart';
import 'package:flutter_firebase_blog/helpers/functions.dart';
import 'package:flutter_firebase_blog/models/client.dart';
import 'package:flutter_firebase_blog/models/post.dart';
import 'package:flutter_firebase_blog/ui/post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PostsActivity extends StatefulWidget {
  const PostsActivity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostsActivityState();
}

class _PostsActivityState extends State<PostsActivity> {
  final UserController _userController = UserController();
  final PostController _postController = PostController();
  late final Client _client;

  File? _imageFile;
  final picker = ImagePicker();

  Future selectImage({ImageSource imageSource = ImageSource.camera}) async {
    XFile? selectedFile = await picker.pickImage(source: imageSource);
    // File imageFile = File(selectedFile!.path);

    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: selectedFile!.path,
        aspectRatioPresets: [
          /*CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio16x9*/
          CropAspectRatioPreset.ratio16x9
        ],
        aspectRatio: const CropAspectRatio(ratioX: 16.0, ratioY: 9.0),
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blueGrey,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          hideBottomControls: true,
          lockAspectRatio: false,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      _imageFile = croppedFile;
    });
  }

  String result = '';

  Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    await _postController.getPostsByUser('').then((value) {
      posts = value;
    });
    return posts;
  }

  void initializer() async {
    await _userController.getUser().then((value) => _client = value);
  }

  @override
  void initState() {
    initializer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<Post>>(
            future: getPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: Colors.lightBlueAccent[50],
                  width: size.width,
                  height: size.height,
                  child: Shimmer(
                    gradient: const LinearGradient(
                      colors: [Colors.white70, Colors.white, Colors.white30],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.mirror,
                    ),
                    enabled: true,
                    child: ListView.builder(
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 1,
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Container(
                                    width: double.infinity,
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    width: 40,
                                    height: 10,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  height: 10,
                                  color: Colors.white,
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                ),
                                const SizedBox(height: 3),
                                Container(
                                  width: double.infinity,
                                  height: 10,
                                  color: Colors.white,
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                ),
                                const SizedBox(height: 3),
                                Container(
                                  width: 80,
                                  height: 10,
                                  color: Colors.white,
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                ),
                                const SizedBox(height: 3),
                                Container(
                                    width: double.infinity,
                                    height: 150,
                                    color: Colors.white),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Container(
                                            height: 20,
                                            width: double.infinity,
                                            color: Colors.blueGrey),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Container(
                                            height: 20,
                                            width: double.infinity,
                                            color: Colors.blueGrey),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Container(
                                            height: 20,
                                            width: double.infinity,
                                            color: Colors.blueGrey),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                  width: double.infinity,
                                ),
                                Container(
                                  height: 10,
                                  width: double.infinity,
                                  color: Colors.white70,
                                )
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 5),
                          ),
                        ),
                      ),
                      itemCount: 6,
                    ),
                  ),
                );
              } else {
                List<Post>? posts = snapshot.data;

                if (posts != null || posts!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        var username =
                            '${posts[index].client!.firstName} ${posts[index].client!.lastName}';
                        var cover = posts[index].cover ?? '';
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 20, top: 10),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  child: (posts[index].client!.avatar != null)
                                      ? Image(
                                          image: NetworkImage(posts[index]
                                              .client!
                                              .avatar
                                              .toString()))
                                      : const Image(
                                          image: AssetImage(
                                              'assets/images/avatar.png'),
                                        ),
                                  radius: 20,
                                ),
                                title: Text(username),
                                subtitle: Text(formattedDate(
                                    posts[index].createdOn as DateTime)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostActivity(
                                                    post: posts[index],
                                                  )));
                                    },
                                    child: Text(
                                      posts[index].title ?? '',
                                      style: const TextStyle(
                                        fontFamily: 'LuxuriousRoman',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PostActivity(
                                                post: posts[index],
                                              )));
                                },
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Colors.teal,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/landscape.png'),
                                          fit: BoxFit.cover)),
                                  child: Stack(
                                    children: [
                                      (cover.isNotEmpty)
                                          ? Image(
                                              image: NetworkImage(posts[index]
                                                  .cover
                                                  .toString()),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            )
                                          : const SizedBox(),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Theme(
                                            data: Theme.of(context).copyWith(
                                              cardColor: Colors.white70,
                                            ),
                                            child: PopupMenuButton(
                                              icon: const FaIcon(
                                                  FontAwesomeIcons.ellipsisV),
                                              color: Colors.white,
                                              itemBuilder: (context) {
                                                return const [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text('Edit'),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text('Delete'),
                                                  ),
                                                ];
                                              },
                                              onSelected: (value) {
                                                switch (value) {
                                                  case 'edit':
                                                    print('edit');
                                                    break;
                                                  case 'delete':
                                                    print('delete');
                                                    break;
                                                  default:
                                                    print('no action');
                                                }
                                              },
                                            )),
                                      ),
                                      /*Positioned(
                                        left: 5,
                                        bottom: 5,
                                        child: Text(
                                          formattedTitle(loremIpsum(8, 1)),
                                          style: const TextStyle(
                                            fontFamily: 'LuxuriousRoman',
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            backgroundColor: Color.fromRGBO(
                                                255, 255, 255, .7),
                                          ),
                                          textScaleFactor: 1,
                                        ),
                                      )*/
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(posts[index]
                                              .likes!
                                              .length
                                              .toString() +
                                          ' Likes'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                          posts[index].views.toString() +
                                              ' Views'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(posts[index]
                                              .comments!
                                              .length
                                              .toString() +
                                          ' Comments'),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox(
                    width: double.infinity,
                    child: Text('No posts found.'),
                  );
                }
                //printer('post', posts![0].post);

              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
              context: context,
              barrierDismissible: false,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              barrierColor: Colors.black45,
              transitionDuration: const Duration(milliseconds: 200),
              pageBuilder: (BuildContext buildContext, Animation animation,
                  Animation secondaryAnimation) {
                GlobalKey _postForm = GlobalKey();
                TextEditingController _postTitle = TextEditingController();
                HtmlEditorController _postContent = HtmlEditorController();
                String? content;
                String? cover;
                DateTime createdOn;
                DateTime updatedOn;
                String userId;
                bool isPublished = true;
                int views = 0;

                return Scaffold(
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Form(
                                key: _postForm,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _postTitle,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter post title';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Post Title',
                                        errorStyle: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ),
                                    HtmlEditor(
                                      controller: _postContent,
                                      htmlEditorOptions:
                                          const HtmlEditorOptions(
                                        hint: 'Your text here...',
                                        //shouldEnsureVisible: true,
                                        //initialText: "<p>text content initial, if any</p>",
                                      ),
                                      htmlToolbarOptions: HtmlToolbarOptions(
                                        toolbarPosition: ToolbarPosition
                                            .aboveEditor, //by default
                                        toolbarType: ToolbarType
                                            .nativeScrollable, //by default
                                        onButtonPressed: (ButtonType type,
                                            bool? status,
                                            Function()? updateStatus) {
                                          print(
                                              "button '${describeEnum(type)}' pressed, the current selected status is $status");
                                          return true;
                                        },
                                        onDropdownChanged: (DropdownType type,
                                            dynamic changed,
                                            Function(dynamic)?
                                                updateSelectedItem) {
                                          print(
                                              "dropdown '${describeEnum(type)}' changed to $changed");
                                          return true;
                                        },
                                        mediaLinkInsertInterceptor:
                                            (String url, InsertFileType type) =>
                                                true,
                                        mediaUploadInterceptor: (PlatformFile
                                                    file,
                                                InsertFileType type) async =>
                                            true,
                                      ),
                                      otherOptions:
                                          const OtherOptions(height: 300),
                                      callbacks: Callbacks(onBeforeCommand:
                                              (String? currentHtml) {
                                        print(
                                            'html before change is $currentHtml');
                                      }, onChangeContent: (String? changed) {
                                        print('content changed to $changed');
                                      }, onChangeCodeview: (String? changed) {
                                        print('code changed to $changed');
                                      }, onChangeSelection:
                                              (EditorSettings settings) {
                                        print(
                                            'parent element is ${settings.parentElement}');
                                        print(
                                            'font name is ${settings.fontName}');
                                      }, onDialogShown: () {
                                        print('dialog shown');
                                      }, onEnter: () {
                                        print('enter/return pressed');
                                      }, onFocus: () {
                                        print('editor focused');
                                      }, onBlur: () {
                                        print('editor unfocused');
                                      }, onBlurCodeview: () {
                                        print(
                                            'codeview either focused or unfocused');
                                      }, onInit: () {
                                        print('init');
                                      }, //this is commented because it overrides the default Summernote handlers
                                          /*onImageLinkInsert: (String? url) {
                                        print(url ?? "unknown url");
                                      },
                                      onImageUpload: (FileUpload file) async {
                                        print(file.name);
                                        print(file.size);
                                        print(file.type);
                                        print(file.base64);
                                      },*/
                                          onImageUploadError: (FileUpload? file,
                                              String? base64Str,
                                              UploadError error) {
                                        print(describeEnum(error));
                                        print(base64Str ?? '');
                                        if (file != null) {
                                          print(file.name);
                                          print(file.size);
                                          print(file.type);
                                        }
                                      }, onKeyDown: (int? keyCode) {
                                        print('$keyCode key downed');
                                        print(
                                            'current character count: ${_postContent.characterCount}');
                                      }, onKeyUp: (int? keyCode) {
                                        print('$keyCode key released');
                                      }, onMouseDown: () {
                                        print('mouse downed');
                                      }, onMouseUp: () {
                                        print('mouse released');
                                      }, onNavigationRequestMobile:
                                              (String url) {
                                        print(url);
                                        return NavigationActionPolicy.ALLOW;
                                      }, onPaste: () {
                                        print('pasted into editor');
                                      }, onScroll: () {
                                        print('editor scrolled');
                                      }),
                                      plugins: [
                                        SummernoteAtMention(
                                            getSuggestionsMobile:
                                                (String value) {
                                              var mentions = <String>[
                                                'test1',
                                                'test2',
                                                'test3'
                                              ];
                                              return mentions
                                                  .where((element) =>
                                                      element.contains(value))
                                                  .toList();
                                            },
                                            mentionsWeb: [
                                              'test1',
                                              'test2',
                                              'test3'
                                            ],
                                            onSelect: (String value) {
                                              print(value);
                                            }),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return SizedBox(
                                                height: 120,
                                                child: Column(
                                                  children: [
                                                    TextButton.icon(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          selectImage(
                                                              imageSource:
                                                                  ImageSource
                                                                      .camera);
                                                        },
                                                        icon: const FaIcon(
                                                            FontAwesomeIcons
                                                                .camera),
                                                        label: const Text(
                                                            "Select from camera")),
                                                    TextButton.icon(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          selectImage(
                                                              imageSource:
                                                                  ImageSource
                                                                      .gallery);
                                                        },
                                                        icon: const FaIcon(
                                                            FontAwesomeIcons
                                                                .image),
                                                        label: const Text(
                                                            "Select from gallery")),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: SizedBox(
                                        height: 180,
                                        width: double.infinity,
                                        child: ClipRRect(
                                            child: (_imageFile == null)
                                                ? Image.asset(
                                                    "assets/images/landscape.png",
                                                    height: 180,
                                                    width: double.infinity,
                                                    fit: BoxFit.contain,
                                                  )
                                                : ((_imageFile != null)
                                                    ? Image.file(
                                                        _imageFile!,
                                                        height: 180,
                                                        width: double.infinity,
                                                        fit: BoxFit.contain,
                                                      )
                                                    : Image.network(
                                                        cover ?? '')),
                                            borderRadius:
                                                BorderRadius.circular(0.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await _postContent
                                            .getText()
                                            .then((value) => content = value);

                                        await _postController
                                            .uploadFile(
                                                file: _imageFile,
                                                directory: 'covers')
                                            .then((value) => cover = value);

                                        Post post = Post(
                                          title: _postTitle.text,
                                          content: content,
                                          isPublished: true,
                                          createdOn: DateTime.now(),
                                          updatedOn: DateTime.now(),
                                          userId: _client.id,
                                          views: 0,
                                          cover: cover,
                                        );

                                        printer('post object', post.dataModel);

                                        await _postController
                                            .create(post.dataModel)
                                            .then((value) {
                                          toast('Post created successfully');
                                          _imageFile = null;
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        });
                                      },
                                      child: const Text(
                                        "Create",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 10,
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
