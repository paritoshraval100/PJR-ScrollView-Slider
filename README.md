PJR Slider
=====================

It is a Scrollview Component which contains nice animation feature of UIScrollview and UIPageController.

Why it is useful to you and what is new in it ?
===============================================================

It is a well structered components which contains Model View Controller design pattern, It will perform different animations then other.

**What is new ?**

It is well structered.
It follows MVC.
It contains differents animations for different views.
It contains Swipe left,swipe right,swipe up,swipe down and images up to down animations.
You can add as many component in given scrollview.

It will defenetly make your app much interesting with its animations.


How to use
=====================

**Import two files**

**PJRPageScrollingView.h** and
**PJRItems.h**


- **Add your items like:** 

```NSString *path = [[NSBundle mainBundle] pathForResource:
@"Places" ofType:@"plist"];```

```NSMutableArray *placeArray = [[NSMutableArray alloc] initWithContentsOfFile:path];```

```NSMutableArray *array = [[NSMutableArray alloc] init];```

```for (int i =0 ; i < [placeArray count] ; i++){```

    NSDictionary *dict = [placeArray objectAtIndex:i];
    PJRItems *item = [[PJRItems alloc] init];
    item.itemTitle = [dict objectForKey:@"placeName"];
    item.itemDesc = [dict objectForKey:@"placeDesc"];
    item.itemImage = [dict objectForKey:@"placeImage"];
    [array addObject:item];
```}```


- **Call Slider view from your controller** 
```
PJRPageScrollingView *pagScrollView = [[PJRPageScrollingView alloc] initWithFrame:self.view.bounds withNumberOfItems:array];
[self.view addSubview:pagScrollView];
```



     
    
    
License
=====================
Paritosh Raval


