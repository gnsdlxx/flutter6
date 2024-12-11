import 'package:flutter_application_2/ui/views/writing_page.dart';
import 'package:flutter_application_2/ui/components/search.dart';
import 'package:flutter_application_2/ui/views/post_detail.dart';
import 'package:flutter_application_2/data/post.dart'; // 기존 게시글 데이터 사용
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  // 기존 게시글 데이터를 로컬 상태로 관리

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0x44009223),
        title: const Text('게시글 보관함'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(type: "post"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: posts.isEmpty
          ? const Center(
              child: Text('보관된 게시글이 없습니다.'),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailPage(post: post),
                    ),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    child: Container(
                      height: 90,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(post['profileUrl'] ?? ''),
                            radius: 25,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post['title'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  post['content'],
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${post['createdAt'].year}/${post['createdAt'].month}/${post['createdAt'].day} '
                                  '${post['createdAt'].hour}:${post['createdAt'].minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          if (post['image'] != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Image.asset(
                                post['image']!,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: SizedBox(
        width: 100,
        height: 40,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          splashColor: const Color(0x44009223),
          highlightElevation: 0.0,
          foregroundColor: Colors.black,
          elevation: 0.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WritePostPage(
                 onPostUploaded: (String title, String content, String imagePath, String author) {
                    // 게시글 추가
                    setState(() {
                      posts.insert(0,{
                        'title': title,
                        'content': content,
                        'createdAt': DateTime.now(),
                        'profileUrl':
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRESQMNAFE8gcZBlZmbJgAf2CEcLvSKpQSvpQ&s', // 기본 프로필 이미지
                        'image': 'assets/images/product8.png', 
                      });
                    });
                  },
                ),
              ),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: const BorderSide(
              color: Color(0x44000000),
            ),
          ),
          child: const Text(
            "글쓰기",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
