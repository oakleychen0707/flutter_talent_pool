import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Card',
      theme: ThemeData(
        primarySwatch: Colors.teal, // 主顏色
        hintColor: Colors.orangeAccent, // 強調顏色
        scaffoldBackgroundColor: Colors.grey[200], // 背景顏色
      ),
      home: ContactCard(),
    );
  }
}

class ContactCard extends StatefulWidget {
  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  int _currentIndex = 0;
  List<ContactInfo> _contacts = [
    ContactInfo(name: 'John Doe', title: '水電工', experience: '1年經驗', phone: '123-456-7890', email: 'john.doe@example.com'),
    ContactInfo(name: 'Jane Smith', title: '防水抓漏技師', experience: '2年經驗', phone: '234-567-8901', email: 'jane.smith@example.com'),
    ContactInfo(name: 'Oakley Chen', title: 'App工程師', experience: '3年經驗', phone: '345-678-9012', email: 'oakley.chen@example.com'),
  ];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Card'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _contacts.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: FrontCard(contact: _contacts[index]),
                  ),
                );
              },
            ),
          ),
          Text('${_currentIndex + 1} / ${_contacts.length}'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class ContactInfo {
  final String name;
  final String title;
  final String experience;
  final String phone;
  final String email;

  ContactInfo({required this.name, required this.title,required this.experience, required this.phone, required this.email});
}

class FrontCard extends StatefulWidget {
  final ContactInfo contact;

  FrontCard({required this.contact});

  @override
  _FrontCardState createState() => _FrontCardState();
}

class _FrontCardState extends State<FrontCard> {
  bool _showBack = false;

  void _flipCard() {
    setState(() {
      _showBack = !_showBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: _showBack ? BackCard(contact: widget.contact) : _buildFrontContent(),
      ),
    );
  }

  Widget _buildFrontContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(height: 10),
          Text(
            widget.contact.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.contact.title,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            widget.contact.experience,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  final ContactInfo contact;

  BackCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Phone: ${contact.phone}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            'Email: ${contact.email}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
