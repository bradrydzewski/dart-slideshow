import 'dart:html';
import 'dart:math';
import 'dart:async';
import 'package:firebase/firebase.dart';

const String BASE = 'https://flickering-fire-7106.firebaseio.com/images/';
const Duration interval = const Duration(seconds: 3);

main() {
  UListElement list = querySelector(".slides");
  Firebase fb = new Firebase(BASE);

  Random rand = new Random(2371298723198);
  int current = 0;
  
  fb.onChildAdded.listen((e) {
        var data = e.snapshot.val();

        LIElement li = new LIElement();
        list.append(li);
        
        ImageElement img = new ImageElement();
        img.src = data["image"];
        li.append(img);
        
        // TODO find a way to catch back up in the slideshow
  });
  

  new Timer.periodic(interval, (_){
    
    // if no children in the list, do nothing
    if (list.children.length == 0){
      return;
    }
    
    // increment the counter
    current++;

    // if we reach the end of the list, then
    // we should return to a random point in the
    // slideshow.
    if (current >= list.children.length) {
      current = rand.nextInt(list.children.length-1);
    }
    
    ImageElement img = list.children.elementAt(current).firstChild;
    ImageElement photo = querySelector("#photo");
    photo.src = img.src;
    img.scrollIntoView();
  });
}
