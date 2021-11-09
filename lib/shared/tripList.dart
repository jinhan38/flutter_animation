import 'package:flutter/material.dart';
import 'package:flutter_animation/models/Trip.dart';
import 'package:flutter_animation/screens/details.dart';

class TripList extends StatefulWidget {
  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List<Widget> _tripTiles = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    ///렌더링 후에 호출됨
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _addTrips();
    });
  }

  ///_addTrips 함수를 렌더링 후에 호출해야
  ///_listKey.currentState 가 null이 아니다
  void _addTrips() {
    // get data from db
    List<Trip> _trips = [
      Trip(
          title: 'Beach Paradise', price: '350', nights: '3', img: 'beach.png'),
      Trip(title: 'City Break', price: '400', nights: '5', img: 'city.png'),
      Trip(title: 'Ski Adventure', price: '750', nights: '2', img: 'ski.png'),
      Trip(title: 'Space Blast', price: '600', nights: '4', img: 'space.png'),
    ];



    int count =0;
    _trips.forEach((Trip trip) {
      Future((){
        count ++;
        return count;
      }).then((value) {
        ///future 함수에서 return한 값이 value로 들어온다
        print("value : $value");

        ///duration 이후 함수를 실행한다
        return Future.delayed(const Duration(milliseconds: 500),(){
          _tripTiles.add(_buildTile(trip));
          if(_listKey.currentState != null){
            _listKey.currentState!.insertItem(_tripTiles.length -1);
          }
        });
      });

    });

  }

  Widget _buildTile(Trip trip) {
    return ListTile(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Details(trip: trip)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${trip.nights} nights',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[300])),
          Text(trip.title,
              style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'location-img-${trip.img}',
          child: Image.asset(
            'images/${trip.img}',
            height: 50.0,
          ),
        ),
      ),
      trailing: Text('\$${trip.price}'),
    );
  }

  ///SlideTransition 에서 사용될  offset값을 가지고 있다.
  Tween<Offset> _offset = Tween(begin: Offset(1,0), end: Offset(0,0));

  @override
  Widget build(BuildContext context) {

    ///_listKey가 없으면 애니메이션이 작동하지 않는다.
    return AnimatedList(
        key: _listKey,
        initialItemCount: _tripTiles.length,
        itemBuilder: (context, index, animation) {

          ///이동하는 Animation 을 구현한다
          return SlideTransition(
            position: animation.drive(_offset),
            child: _tripTiles[index],
          );
        });
  }
}
