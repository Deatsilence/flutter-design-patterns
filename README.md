[![en](https://img.shields.io/badge/lang-en-blue.svg)](https://github.com/Deatsilence/flutter-design-patterns/blob/main/README.md)
[![tr](https://img.shields.io/badge/lang-tr-red.svg)](https://github.com/Deatsilence/flutter-design-patterns/blob/main/README.tr.md)

<h1 align="center"><a id="head">Design Patterns with Flutter</h1>

- <h2 align="left">What are Design Patterns briefly?</h2>
  Design patterns are important tools widely used in software development. These patterns can improve code quality, consistency and reusability by controlling the creation, assembly and communication of objects.

- Creational Patterns

  - [Factory Method](#factory-method)
  - [Abstract Factory](#abstract-factory)
  - [Singleton](#singleton)
  - [Builder](#builder)
  - [Prototype](#prototype)

- Structural Patterns

  - [Adapter](#adapter)
  - [Bridge](#bridge)
  - [Composite](#composite)
  - [Decorator](#decorator)
  - [Facade](#fecade)
  - [Flyweight](#flyweight)
  - [Proxy](#proxy)

- Behavioral Patterns

  - [Chain of Responsibility](#chainofresponsibility)
  - [Iterator](#iterator)
  - [Interpreter](#interpreter)
  - [Observer](#observer)
  - [Command](#command)
  - [Mediator](#mediator)
  - [State](#state)
  - [Strategy](#strategy)
  - [Template Method](#template-method)
  - [Visitor](#visitor)
  - [Memento](#momento)

- <h2 align="left"><a id="factory-method">Factory Method (Creational Patterns)</h2>
  A factory design pattern is a generative design pattern that helps to abstract how an object is created. This makes your code more flexible and extensible.

The basic idea of the factory design pattern is to delegate object creation to a factory class. This factory class determines which object is created.

<h4 align="left">The factory design pattern has two main components</h4>

- **Ürün:** The object to be created.
- **Fabrika:** The class that creates the product object.

<h5 align="left">Advantages of factory design pattern:</h5>

- Makes your code more flexible and extensible.
- It makes your code more readable and understandable by abstracting the object creation process.
- It makes the software development process more efficient.

<h5 align="left"> Disadvantages of the factory design pattern:</h5>

- It may be difficult to use in complex applications.
- It may cause you to write more code.

**Sample Scenario**

So how can we apply this in a real application, package, etc. Let's look at it. As per our scenario, we want to produce a platform specific button. For this, we first start creating an **abstract** class. In it, we write an **abstract** method with the name build that returns **Widget**. I want **onPressed** and **child** as the most basic parameters for this method. This may change according to your scenario. I use the Platform class with `import 'dart:io' show Platform;` to learn the current platform. Alternatively, `theme.of(context).platform.` can be used. According to the current platform, we have an abstract factory class that returns the button specific to that platform.

```dart
abstract class PlatformButton {
  Widget build({required VoidCallback onPressed, required Widget child});

  factory PlatformButton() {
    if (Platform.isAndroid) {
      return AndroidButton();
    } else if (Platform.isIOS) {
      return IOSButton();
    } else {
      return AndroidButton();
    }
  }
}
```

We created our button classes specific to 2 platforms, IOS and Android, and implemented our **PlatformButton** class and returned our related buttons in the widget.

```dart
final class IOSButton implements PlatformButton {
  @override
  Widget build({required VoidCallback onPressed, required Widget child}) => CupertinoButton(
        onPressed: onPressed,
        child: child,
      );
}

final class AndroidButton implements PlatformButton {
  @override
  Widget build({required VoidCallback onPressed, required Widget child}) => ElevatedButton(
        onPressed: onPressed,
        child: child,
      );
}
```

So how can we use this on the UI side?

```dart
import 'dart:developer';

import 'package:design_patterns/patterns/factory/platform_button.dart';
import 'package:flutter/material.dart';

class FactoryView extends StatelessWidget {
  FactoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformButton().build(
              onPressed: () => log("Platform Button Pressed"),
              child: const Text("Platform Button"),
            ),
          ],
        ),
      ),
    );
  }
}
```

[Back to the beginning of the documentation](#head)

- <h2 align="left"><a id="abstract-factory">Abstract Factory (Creational Patterns)</h2>

The abstract factory design pattern uses a factory class to create objects from multiple families. This pattern abstracts the object creation process, making your code more readable and flexible.

<h4 align="left">The abstract factory design pattern has two main components</h4>

- Abstract factory:\*\* A class used to create objects from multiple families.
- Concrete factory:\*\* A class that concretises the abstract factory and is used to create objects from a specific family.

<h5 align="left">Advantages of the abstract factory design pattern</h5>

- Makes your code more flexible and extensible.
- It makes your code more readable and understandable by abstracting the object creation process.
- It makes the software development process more efficient.

<h5 align="left"> Disadvantages of the abstract factory design pattern</h5>

- It may be difficult to use in complex applications.
- It may cause you to write more code.

**Sample Scenario**

So how can we implement this in a real application, package, etc. Let's look at it. Although it is natural to confuse it with **Factory Method** at first glance, there is a slight difference between them. This difference is that **Factory Method** produces objects that should be in the same family by abstracting them. For example, _IOS Button, Android Button, Linux Button, etc._ can cover the button family. **Abstract Factory** generates objects of different families by abstracting them. For example, it can produce different family classes such as _Button, Indicator, etc._ within itself. After adding a platform-specific indicator in addition to the platform-specific button we made for **Factory Method**, let's generate the components of these two different families with **Abstract Factory**. I will show 2 different techniques for this. In the 1st technique, **Singleton + Abstract Factory** design patterns are used together. In the 2nd technique, static methods are used in a class.

**1st Technique (Singleton + Abstract Factory):**
Firstly, we create our **AbstractFactory** class as an **abstract** class. In it we create 2 **abstract methods** named **buildButton() and buildIndicator()**.

```dart
abstract class AbstractFactory {
  Widget buildButton({required VoidCallback onPressed, required Widget child});
  Widget buildIndicator();
}
```

Then we create a **Singleton** class named **AbstractFactoryImpl2** and implement the **AbstractFactory** class.
In **AbstractFactoryImpl2**, we override our methods that return widgets specific to families.

```dart
final class AbstractFactoryImpl2 implements AbstractFactory {
  AbstractFactoryImpl2._init() {
    log("AbstractFactoryImpl2 Private constructor ran");
  }

  static AbstractFactoryImpl2? _instance;

  static AbstractFactoryImpl2 get instance => _instance ??= AbstractFactoryImpl2._init();

  @override
  Widget buildButton({required VoidCallback onPressed, required Widget child}) {
    return PlatformButton().build(onPressed: onPressed, child: child);
  }

  @override
  Widget buildIndicator() {
    return PlatformIndicator().build();
  }
}

```

So how can we use this on the UI side?

```dart
import 'dart:developer';

import 'package:design_patterns/patterns/abstract_factory/abstract_factory.dart';
import 'package:flutter/material.dart';

class AbstractFactoryView extends StatelessWidget {
  const AbstractFactoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbstractFactoryImpl2.instance.buildButton(
              onPressed: () => log("Platform Button Pressed"),
              child: const Text("Platform Button"),
            ),
            AbstractFactoryImpl2.instance.buildIndicator(),
          ],
        ),
      ),
    );
  }
}

```

**2. Technique (Abstract Factory):**

```dart
final class AbstractFactoryImpl {
  static Widget buildButton({required VoidCallback onPressed, required Widget child}) {
    return PlatformButton().build(onPressed: onPressed, child: child);
  }

  static Widget buildIndicator() {
    return PlatformIndicator().build();
  }
}

```

So how can we use this on the UI side?

```dart
import 'dart:developer';

import 'package:design_patterns/patterns/abstract_factory/abstract_factory.dart';
import 'package:flutter/material.dart';

class AbstractFactoryView extends StatelessWidget {
  const AbstractFactoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbstractFactoryImpl.buildButton(
              onPressed: () => log("Platform Button Pressed"),
              child: const Text("Platform Button"),
            ),
            AbstractFactoryImpl.buildIndicator(),
          ],
        ),
      ),
    );
  }
}
```

Which method to use depends on the requirements of the project and other parameters.

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="singleton">Singleton (Creational Patterns)</h2>
  The Singleton design pattern allows only one object to be created from a class. This pattern is used when a single object is needed.

<h4 align="left">The Singleton design pattern has two main components</h4>

- **Singleton class:** This class allows only one object to be created.
- **Singleton object:** The only object created from the Singleton class.

<h5 align="left">Advantages of Singleton design pattern</h5>

- Useful in situations where a single object is needed.
- Makes your code more readable and understandable.
- It makes the software development process more efficient.

<h5 align="left"> Disadvantages of the factory design pattern</h5>

- It may be difficult to use in complex applications.
- It may cause you to write more code.

**Sample Scenario**

So how can we apply this in a real application, package, etc. It is usually useful to use it for the network layer of the application. There is a network service layer that brings similar locations according to the locations entered below.

```dart
import 'dart:io';

import 'package:design_patterns/patterns/singleton/model/base_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PredictionsNetworkManager {
  PredictionsNetworkManager._init() {
    final baseOptions = BaseOptions(baseUrl: _baseUrl);
    _dio = Dio(baseOptions);
  }
  static const String _apiKey = "APIKEY";
  static const String _baseUrl = "BASEURL";

  static PredictionsNetworkManager? _instance;
  static PredictionsNetworkManager get instance {
    _instance ??= PredictionsNetworkManager._init();
    return _instance!;
  }

  late Dio _dio;

  Future<dynamic> dioGet<T extends BaseModel>(String place, T model) async {
    try {
      final response = await _dio.get("$_baseUrl=$place&key=$_apiKey");

      switch (response.statusCode) {
        case HttpStatus.ok:
          final responseBody = response.data;
          if (responseBody is List) {
            return responseBody.map((e) => model.fromJson(e)).toList();
          } else if (responseBody is Map) {
            return model.fromJson(responseBody.cast<String, dynamic>()); //! compute will come here
          }
          return responseBody;
        // case HttpStatus.badRequest
        default:
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

```

So how can we use this on the UI side?

```dart
import 'package:design_patterns/patterns/singleton/model/place_model.dart';
import 'package:design_patterns/patterns/singleton/singleton.dart';
import 'package:design_patterns/patterns/singleton/singleton_network_manager.dart';
import 'package:flutter/material.dart';

class SingletonView extends StatefulWidget {
  const SingletonView({super.key});

  @override
  State<SingletonView> createState() => _SingletonViewState();
}

class _SingletonViewState extends State<SingletonView> {
  final s1 = Singleton.instance;
  final s2 = Singleton.instance;
  final s3 = Singleton.instance;

  final s4 = SingletonWithFactory();
  final s5 = SingletonWithFactory();
  final s6 = SingletonWithFactory();

  late final response;
  @override
  void initState() {
    PredictionsNetworkManager.instance.dioGet<Place>("Ankara", Place()).then((value) => response = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                if (response is Place) {
                  return Text("${(response as Place).name}");
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

```

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="prototype">Prototype (Creational Patterns)</h2>
  A prototype design pattern is a design pattern that uses a prototype object to create copies of objects. This can be more efficient than creating objects directly, especially if the creation of objects is complex or time-consuming.

<h4 align="left">The Prototype design pattern has three main components</h4>
- **Prototype:** The object to be copied.
- **Copier:** The class that copies the prototype object.
- **Users:** Classes that use the copied objects.

<h5 align="left">Advantages of the Prototype design pattern</h5>
- Makes the creation of objects more efficient.
- Facilitates the creation of a number of copies with the same properties of objects.
- It allows objects to be created independently of a given state.

<h5 align="left"> Disadvantages of the Prototype design pattern</h5>

- Changing the prototype object can also change all copied objects.
- When the property of the prototype object is changed, it is also necessary to change the properties of the copied objects.

**Sample Scenario**

Let's say we have a model called Person and we want to be able to copy directly from it if there is a Person created without creating a Person from scratch.

```dart
import 'package:flutter/material.dart';

@immutable
final class Person {
  final String? name;
  final String? lastName;
  final int? age;
  final String? email;

  const Person({
    required this.name,
    required this.lastName,
    required this.age,
    required this.email,
  });

  Person copyWith({
    String? name,
    String? lastName,
    int? age,
    String? email,
  }) =>
      Person(
          name: name ?? this.name,
          lastName: lastName ?? this.lastName,
          age: age ?? this.age,
          email: email ?? this.email);

  Person clone() => copyWith(name: name, lastName: lastName, age: age, email: email);
}

```

So how can we use this on the UI side?

```dart
import 'dart:developer';
import 'package:design_patterns/patterns/prototype/prototype.dart';
import 'package:flutter/material.dart';

class PrototypeView extends StatelessWidget {
  const PrototypeView({super.key});

  @override
  Widget build(BuildContext context) {
    const person1 = Person(name: "mert", lastName: "dogan", age: 23, email: "m@gmail");
    const person2 = Person(name: "mete", lastName: "dogan", age: 35, email: "me@gmail");
    final person3 = person1.clone();
    final person4 = person2.clone();

    log("${person3.name} ${person3.lastName}  ${person3.age}  ${person3.email} ");
    log("${person4.name} ${person4.lastName}  ${person4.age}  ${person4.email} ");

    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}

```

```terminal
Output:
[log] mert dogan  23  m@gmail
[log] mete dogan  35  m@gmail
```

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="adapter">Adapter (Structural Patterns)</h2>
  The Adapter design pattern is a structural design pattern that allows objects with incompatible interfaces to work together. This pattern is applied to reuse an existing class or interface class by adapting it to a different interface class.

The Adapter pattern makes the interfaces of two different classes or interfaces similar to each other, allowing these classes or interfaces to be used together. In this way, it is possible to use an existing class or interface class in a new system or project without having to change or rewrite it.

<h4 align="left">The adapter design pattern has two main components</h4>

- Adapted class or interface:\*\* The purpose of the adapter pattern is to adapt this class or interface to have a different interface.
- **Adaptor class:** The adapter class is the class that adapts the adapted class or interface to have a different interface.
- **Customer class:** A class that uses the interface of the adapter class.

<h5 align="left">Adapter design pattern advantages</h5>

- It allows you to use an existing class or interface in a new system or project without changing it.
- It makes it easier to bring together different technologies or platforms.
- It allows to extend the functionality of a class or interface.

<h5 align="left"> Disadvantages of the Adapter design pattern</h5>

- The adapter class must support the full functionality of the adapted class or interface.
- The adapter class may be dependent on the code of the adapted class or interface.

**Sample Scenario**

So how can we implement this in a real application, package, etc. Let's look at it. Let's have two different APIs for our scenario.
Let their names be **PostAPI1** and **PostAPI2**. **PostAPI1** fetches the title (_title_) and description (_description_) of Youtube videos. **PostAPI2** will get the title (_header_) and description (_bio_) of the posts on Medium. As you can see, although basically two APIs return one title and description, the **Keys** returned from the two APIs are different. _title - header_, _description - bio_. Our goal is to make the data returned from these two APIs similar to each other as if they were returned from a single API.

First of all, we need to create a model where the relevant data will come from.

```dart
@immutable
final class Post {
  final String title;
  final String bio;

  Post({
    required this.title,
    required this.bio,
  });
}
```

Then we define our APIs.

```dart
class PostAPI1 {
  String getYoutubePosts() {
    return '''
    [
      {
        "title": "Automatic code generation with Fluuter",
        "description": "Generate automatically"
      },
      {
        "title": "Twitter Clone code generation with Fluuter",
        "description": "Generate automatically"
      }
    ]
    ''';
  }
}

class PostAPI2 {
  String getMediumPosts() {
    return '''
    [
      {
        "header": "Medium header1",
        "bio": "Medium bio1"
      },
      {
        "header": "Medium header2",
        "bio": "Medium bio2"
      }
    ]
    ''';
  }
}
```

We make an **abstract** API class and put the getPosts() abstract method in it. We will use this in the **Adapter** classes of each API in a moment.

```dart
abstract class IPostAPI {
  List<Post> getPosts();
}
```

We create an **Adapter** class for each API.

```dart
class PostAPI1Adapter implements IPostAPI {
  final _api = PostAPI1();

  @override
  List<Post> getPosts() {
    final data = jsonDecode(_api.getYoutubePosts()) as List;

    return data
        .map(
          (e) => Post(
            title: e["title"],
            bio: e["description"],
          ),
        )
        .toList();
  }
}

class PostAPI2Adapter implements IPostAPI {
  final _api = PostAPI2();

  @override
  List<Post> getPosts() {
    final data = jsonDecode(_api.getMediumPosts()) as List;

    return data
        .map(
          (e) => Post(
            title: e["header"],
            bio: e["bio"],
          ),
        )
        .toList();
  }
}
```

After doing the necessary **Adapter** operations, we create a class named **PostAPI** to be used on the UI side. **IPostAPI** is implemented in this class. As per our scenario, an object is generated from **Adapter** classes for each API. With the getPost() override method, we make our data returned from these APIs ready for use.

So how can we use this on the UI side?

```dart
import 'package:design_patterns/patterns/adapter/adapter.dart';
import 'package:flutter/material.dart';

class AdapterView extends StatelessWidget {
  const AdapterView({super.key});

  @override
  Widget build(BuildContext context) {
    final postAPI = PostAPI();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: postAPI.getPosts().length,
                itemBuilder: (BuildContext context, int index) {
                  final post = postAPI.getPosts()[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.bio),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="builder">Builder (Creational Patterns)</h2>
  The Builder pattern is a structural design pattern that divides the construction of a complex object into two classes.

<h4 align="left">The Builder design pattern has two main components</h4>

- **Builder class:** This class performs the construction of the object.
- **Object class:** This class provides a representation of the constructed object.

The Builder class provides a set of methods for the construction of the object. These methods are used to set the properties of the object. When the object is built, the Builder class calls the build() method. This method completes the construction of the object and returns the object.

<h5 align="left">Advantages of the Builder design pattern</h5>

- It makes it easy to build complex objects step by step.
- It allows different representations of the same object to be built without changing the build process.
- Makes it easy to test the building process of complex objects.
- Readability and Maintainability: The Builder design pattern makes the object building process more readable and easier to maintain. Each step is clearly defined and only the corresponding Builder class is changed when it needs to be changed.

<h5 align="left">Disadvantages of the Builder design pattern:</h5>

- Using Builder for simple objects can create unnecessary complexity. This design pattern only makes sense when it is necessary to build complex objects.

- Performance: The performance of the Builder pattern can be affected depending on the number of methods used in the construction of objects. If a large number of methods are used, this can negatively affect performance.

<h5 align="left">The builder pattern can be used in the following situations:</h5>

- If different representations of the object need to be created.
- If the construction process of the object needs to be tested.

<h5 align="left">To use the Builder pattern, you can follow these steps:</h5>

- Create the Builder class. This class should contain all the methods necessary for the construction of the object.
- Create the Object class. This class must provide a representation of the object being built.
- Build the object using the Builder class.

**Sample Scenario**

So how can we implement this in a real application, package, etc. Let's look at it. We want to delete the photo we took as a scenario after pressing a button 3 times and we want to fill in the date of deletion of the photo. Before doing this, we want to fill our object step by step. When we press the button 3 times, we will see that the deletion date of the photo has expired. Doing this process using the builder design pattern has given us more **flexibility**, **readability**.

I am creating a sealed class because we will pass the relevant photo to the **InformationsOfPhoto** widget class as per our scenario. Under normal conditions, it will be enough to create one class to be created and one builder class.

```dart
sealed class Photo {
  String? name;
  Size? size;
  DateTime? createdDate;
  DateTime? deletedDate;
}
```

Then we create a class named NotPhotoPhotoBuilder. This class is a class that we will create from the builder method. We implement the Photo class to get our members.

```dart
final class PhotoBuilder implements Photo {
  @override
  String? name;
  @override
  Size? size;
  @override
  DateTime? createdDate;
  @override
  DateTime? deletedDate;

  PhotoBuilder({
    this.name,
    this.size,
    this.createdDate,
    this.deletedDate,
  });
```

Then we create a PhotoBuilder class and create setter methods for each member. Finally, we create a build method. This will return us our object.

```dart
final class PhotoBuilder implements Photo {
  @override
  String? name;
  @override
  Size? size;
  @override
  DateTime? createdDate;
  @override
  DateTime? deletedDate;

  PhotoBuilder({
    this.name,
    this.size,
    this.createdDate,
    this.deletedDate,
  });

  PhotoBuilder setName({required String name}) {
    this.name = name;
    return this;
  }

  PhotoBuilder setSize({required Size size}) {
    this.size = size;
    return this;
  }

  PhotoBuilder setCreatedDate({required DateTime createdDate}) {
    this.createdDate = createdDate;
    return this;
  }

  PhotoBuilder setDeletedDate({required DateTime deletedDate}) {
    this.deletedDate = deletedDate;
    return this;
  }

  NotPhotoPhotoBuilder build() => NotPhotoPhotoBuilder(
        name: name,
        size: size,
        createdDate: createdDate,
        deletedDate: deletedDate,
      );
}
```

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="bridge">Bridge (Structural Patterns)</h2>
  Bridge design pattern is a design pattern used to combine two independent hierarchical structures (abstraction and implementation) and to allow them to be modified separately. This pattern aims to create a more flexible structure by separating the abstraction of an object and the functionality (implementation) that operates on that abstraction.

<h4 align="left">Bridge design pattern has 4 main components</h4>

**Abstraction:** This is the layer where the client interacts with an interface and where functionality is not fully realised.

**Refined Abstraction:** These are subclasses of Abstraction and address a specific situation.

**Implementation:** This is the layer that actually implements the abstraction.

**Concrete Implementation:** These are subclasses of Implementation and actually implement a specific case.

<h5 align="left">Advantages of the Bridge design pattern</h5>

- Flexibility and Extensibility: The abstraction and implementation can be changed independently of each other, which facilitates changes to the system.

- Encapsulation: Application details can be hidden from the abstraction. The client interacts only with the abstraction.

- Change Management: Changes on one side do not affect the other. For example, only the abstraction can change and the application can remain unchanged, or vice versa.

<h5 id="bridge" align="left"> Disadvantages of the Bridge design pattern</h5>

- Complexity: The implementation of the pattern can sometimes lead to complexity, especially if the size of the project is small or the requirements are simple, this complexity may be unnecessary.

**Sample Scenario**

So how can we implement this in a real application, package, etc. Let's look at it. Due to our scenario, we want to use our own video processing technology instead of the video processing technology of applications such as Youtube, Netflix, Amazon Prime, etc. in our project. While doing this, we need to consider the potential for applications with different video processing technologies to be included in our project in the future. At this point, **Birdge Design Pattern** comes into play. Our aim is to ensure that the old code structure can be renewed and continue to function whenever it is renewed.

As per our scenario, we are writing an **abstract** class for our own **Video Processor** technology. In it we have a method signature named **process(String videoFile)**.

```dart
abstract class VideoProcessor {
  void process({required String videoFile});
}
```

Then we define an interface for **Video**. In it, we ensure that our **Video Processor** technology is implemented compulsorily. Then we define an empty method named **play(String videoFile)** for the video.

```dart
interface class Video {
  VideoProcessor processor;

  Video({required this.processor});

  void play({required String videoFile}) {}
}
```

Now let's start running our scenario for Netflix and Youtube. We create separate classes for both Netflix and Youtube and inherit from the **Video** interface.

```dart
class NetflixVideo implements Video {
  @override
  VideoProcessor processor;

  NetflixVideo({
    required this.processor,
  });

  @override
  void play({required String videoFile}) {
    processor.process(videoFile: videoFile);
  }
}

class YoutubeVideo implements Video {
  @override
  VideoProcessor processor;

  YoutubeVideo({
    required this.processor,
  });

  @override
  void play({required String videoFile}) {
    processor.process(videoFile: videoFile);
  }
}
```

Now it is time to implement our **Video Processor** technology for the related video/videos. For this, let's assume that we support HD and UHD (4K) video quality. For each video quality, we get **instantiation** from our **Video Processor** **abstract** class.

```dart
class HDProcessor implements VideoProcessor {
  @override
  void process({required String videoFile}) {
    log("$videoFile is Processing HD Processor");
  }
}

class UHD4KProcessor implements VideoProcessor {
  @override
  void process({required String videoFile}) {
    log("$videoFile is Processing UHD 4K Processor");
  }
}
```

Due to our scenario, we are using our own **Video Processor** technology for 2 different companies and 2 different video quality.

Afterwards, Amazon Prime also took place in our application and let's assume that we want to do this with QUHD 8K video quality.

```dart
class AmazonPrimeVideo implements Video {
  @override
  VideoProcessor processor;

  AmazonPrimeVideo({
    required this.processor,
  });

  @override
  void play({required String videoFile}) {
    processor.process(videoFile: videoFile);
  }
}

class QUHD8KProcessor implements VideoProcessor {
  @override
  void process({required String videoFile}) {
    log("$videoFile is Processing UHD 8K Processor");
  }
}

```

So how can we use this on the UI side?

```dart
import 'package:design_patterns/patterns/bridge/bridge.dart';
import 'package:flutter/material.dart';

class BridgeView extends StatefulWidget {
  const BridgeView({super.key});

  @override
  State<BridgeView> createState() => _BridgeViewState();
}

class _BridgeViewState extends State<BridgeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bridge Design Pattern"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Video youtubeVideo = YoutubeVideo(processor: HDProcessor());
                youtubeVideo.play(videoFile: "abc.mp4");

                const text = "The video playing as HD Quality in Youtube";
                const snackbar = SnackBar(content: Text(text));

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text("Watch a HD Video in Youtube"),
            ),
            OutlinedButton(
              onPressed: () {
                Video netflixVideo = NetflixVideo(processor: UHD4KProcessor());
                netflixVideo.play(videoFile: "abc.mp4");

                const text = "The video playing as UHD 4K Quality in Netflix";
                const snackbar = SnackBar(content: Text(text));

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text("Watch a UHD 4K Video in Netflix"),
            ),
            OutlinedButton(
              onPressed: () {
                Video amazonPrimeVideo = AmazonPrimeVideo(processor: QUHD8KProcessor());
                amazonPrimeVideo.play(videoFile: "abc.mp4");

                const text = "The video playing as QUHD 8K Quality in Amazon Prime";
                const snackbar = SnackBar(content: Text(text));

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
              },
              child: const Text("Watch a QUHD 8K Video in Amazon Prime"),
            ),
          ],
        ),
      ),
    );
  }
}

```

<img src="https://user-images.githubusercontent.com/78795973/282323920-b934655b-f8c4-4fe7-b12b-5b0034b67ba5.png" width="250"> <img src="https://user-images.githubusercontent.com/78795973/282323923-7b57245f-f14f-40e3-9758-a4db458fce52.png" width="250"> <img src="https://user-images.githubusercontent.com/78795973/282323927-2cbcd660-b69f-42a1-ae8a-8b223fb60eda.png" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="composite">Composite (Structural Patterns)</h2>
  The Composite design pattern is a powerful structural pattern that allows you to treat individual objects and composites of objects in the same way. It helps you create object hierarchies that treat both parts (individual objects) and wholes (composite objects) in the same way.

<h4 align="left">There are three main components of the composite design pattern</h4>

- **Abstract Interface:** This is the foundation of the model. It defines the common behaviour that all objects in the hierarchy, both individual and composite, must follow.
- **Concrete Classes:** These are implementations of the abstract interface representing specific types of objects. Each class defines its own behaviour for the interface methods.
- **Client Code:** This is the code that interacts with objects in the hierarchy. Clients only see the abstract interface, allowing them to treat both individual objects and composites in the same way

<h5 align="left">Advantages of composite design pattern</h5>

- Clients do not need to handle different object types differently.
- More flexible and reusable code You can easily add new item types that fit the common interface.
- Easier maintenance Changes to one item type do not necessarily affect others.
- Improved code readability: The code reflects the real-world structure of your data.

<h5 align="left"> Disadvantages of the Composite design pattern</h5>

- Let's not make a big hierarchical scan, performance can be impressive.

**Sample Scenario**

For example, there are certain categories that you feel belong to the same group. For example, there are certain categories in an e-commerce application. Under these categories, there are subcategories or headings related to the relevant category. To build these structures more easily and flexibly, **Composite Design Pattern** comes into play. We can either handle related objects individually, or we can handle categories as multiple and build the hierarchy. Our goal will be to provide this flexibility.

Now the first thing we will build according to our scenario will be **Abstract Class** which will provide the common structure.

```dart

import 'package:flutter/material.dart';

/// Abstract class representing an item that can be added to a shopping cart.
abstract class CartItem<T extends dynamic> {
  /// Returns the name of the item.
  String getName();

  /// Returns the price of the item.
  double getPrice();

  /// Builds and returns the widget representation of the item.
  T buildItemWidget();
}

```

Then we create a class named **Product** for any product. We start building the structure for a single product by inheriting from the **Abstract** class named **CartItem** that we have created this class. Since it will hold information about the product, we write the necessary variables. Remember, our scenario will be an E-commerce application. Since the **buildItemWidget()** method returns generic, we prefer to write a **Card** for the product.

```dart
/// Represents a single product that can be added to a shopping cart.
final class Product implements CartItem<dynamic> {
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  int quantity;

  /// Constructs a new instance of the [Product] class.
  Product({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.quantity = 0,
  });

  @override
  String getName() => title;

  @override
  double getPrice() => price * quantity;

  @override
  dynamic buildItemWidget() => Card(
        child: ListTile(
          leading: Image.network("https://picsum.photos/200", width: 60, height: 60),
          title: Text(title),
          subtitle: Text(description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Quantity: $quantity'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {}, // Implement quantity increment
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {}, // Implement quantity decrement
              ),
            ],
          ),
        ),
      );
}
```

Now it is time to build a product tree collectively. In our scenario, we will consider the **Car** and **Desktop Computer** categories. Since these categories can be divided into many parts (wheels, motherboard, etc.)
We create a class named **Category** that inherits from **CartItem** **Abstract** class to manage related structures in a common way. The **buildItemWidget()** method returns the **ExpansionPanel** and we collect other similar products in the **final List<CartItem<dynamic>> children** list under a single common category heading.

```dart
final class Category implements CartItem<dynamic> {
  final String name;
  final List<CartItem<dynamic>> children;
  bool isExpanded; // Track if category is expanded to show children

  /// Constructs a new instance of the [Category] class.
  Category({
    required this.name,
    required this.children,
    this.isExpanded = false,
  });

  @override
  String getName() => name;

  @override
  double getPrice() => children.fold(0, (sum, child) => sum + child.getPrice());

  @override
  dynamic buildItemWidget() => ExpansionPanel(
        headerBuilder: (context, isExpanded) => Text(name),
        body: Column(
          children: children.map((child) => child.buildItemWidget() as Widget).toList(),
        ),
        isExpanded: isExpanded,
      );
}
```

Let's see what kind of usage scenario can be on the UI side. First of all, we create a list to set the relevant category and single products. As I said before, our categories will be **Desktop Computer** and **Car**. There will be related products in the sub-products.

```dart
final List<Category> categories = [
    Category(
      name: "Desktop Computer",
      children: [
        Product(
          title: "Main Board",
          description: "Part of the computer",
          imageUrl: "imageUrl#1",
          price: 1000,
        ),
        Product(
          title: "CPU",
          description: "Part of the computer",
          imageUrl: "imageUrl#2",
          price: 2000,
        )
      ],
    ),
    Category(
      name: "Car",
      children: [
        Product(
          title: "Electiric car",
          description: "type of the cars",
          imageUrl: "imageUrl#1",
          price: 9000,
        ),
        Product(
          title: "wheel",
          description: "Part of the cars",
          imageUrl: "imageUrl#2",
          price: 1000,
        )
      ],
    ),
  ];
```

We display categories and single product using **ExpansionPanelList**.

```dart
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  categories[index].isExpanded = !categories[index].isExpanded;
                });
              },
              children: [
                categories[CategoryType.desktopComputer.index].buildItemWidget(),
                categories[CategoryType.car.index].buildItemWidget(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: product.buildItemWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
```

<img src="https://user-images.githubusercontent.com/78795973/287830530-ea687dcd-3c1a-4541-b034-6e5a34dcf0ac.png" width="250"> <img src="https://user-images.githubusercontent.com/78795973/287832109-fa70e1ec-4af4-445a-925f-e1d6eba93576.png" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="decorator">Decorator (Structural Patterns)</h2>
  The Decorator design pattern is a design pattern used to dynamically add new properties to an object. This is done without changing or extending the functionality of the base object. The Decorator design pattern provides flexibility and maintainability when used correctly. However, like any design pattern, it is important to evaluate whether it suits your application requirements.

<h4 align="left">The Decorator design pattern has 3 main components</h4>

- **Abstract Component Interface(OPTIONAL):** This interface is completely optional. You can create an **abstract** behaviour for the component to be decorated.
- **Concrete Component:** This is the pure form of the component to be decorated. Optionally **abstract component interface** can be implemented.
- **Abstract Decorator Class:** Provides an **abstract** layer to decorator classes for the component to be decorated. The decor classes to be used inherit from this class.
- **Decorator Class:** Decorates the component to be decorated. More than one **decorator** class can be made for the component to be decorated.

<h5 align="left">Advantages of the Decorator design pattern</h5>

- Flexibility: The Decorator pattern provides a flexible way of dynamically adding behaviour to objects. Adding new responsibilities or removing existing ones can be done without changing classes.
- Open-Closed Principle: The Decorator pattern ensures that classes are open (allowing adding new behaviours) and closed (not modifying existing code). This helps your code to be more maintainable.
- Composite Objects: The Decorator pattern allows you to combine other objects on top of an object. This allows you to create complex structures by combining an object in different combinations.

<h5 align="left">Disadvantages of the Decorator design pattern</h5>

- Code Complexity: When the Decorator pattern is used, a number of classes are created to add additional responsibilities to an object. This can lead to code complexity over time.
- Lots of Small Objects: The Decorator pattern requires a class to be created for each decorator class. This can lead to a large number of small objects and an increase in project size.
- Logical Ordering of Wrappers: The order of the decorators is important in the Decorator pattern. In some cases, incorrect determination of the order of the decorators may lead to unexpected results.
- Complexity of Composite Objects: The complexity of composite objects can increase by adding multiple decorators. This can lead to a structure that is difficult to understand and maintain.

**Örnek Senaryo**

Let's consider an E-commerce application in our example scenario. In this E-commerce application, a product may have more than one behaviour (appearance in terms of UI or logically). For example, a product may be out of stock, on sale, or it may be indicated that it is a new product. In these cases, we will add a feature thought while improving our code by producing different decors for the same object. We will use **Decorator Design Pattern** for this.

Firstly, I am making an **Abstract Component Interface** named ProductCard.

```dart
/// Abstract component class
/// [ProductCard] is the base class for all concrete components, including
abstract class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context);
}
```

Then I design the **Concrete Component** class that inherits **ProductCard**. This class will be the pure form of our Product. Our product will have a picture, name and price.

```dart
/// Concrete component class
/// [SimpleProductCard] is a simple product card with an image, name, and price.
base class SimpleProductCard extends ProductCard {
  final String imageUrl;
  final String productName;
  final double price;

  const SimpleProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Image.network(imageUrl, height: 150, width: 150),
          Text(productName),
          Text("$price"),
        ],
      ),
    );
  }
}
```

Then we make the **Abstract Decorator** class, which will be inherited by the decorator classes, which is the most important stage. This class takes 1 **ProductCard** and calls the **build()** method of the received component. This step is critical, because during the implementation of multiple decorators, we ensure that each decorator works independently from other decorators.

```dart
/// Decorator abstract class
/// [ProductCardDecorator] is the base class for all concrete decorators,
abstract class ProductCardDecorator extends ProductCard {
  final ProductCard productCard;

  const ProductCardDecorator({required this.productCard, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productCard.build(context);
  }
}
```

It's time to write our **Decorator** classes. According to our scenario, a product is expected to be out of stock, a new product or on sale. We design 1 **Decorator** for each possibility. First, we design the **OnSaleDecorator** Decorator. We add a simple **On Sale** text to the upper left corner of this decorator product.

```dart
/// Concrete decorator class for on sale products
/// [OnSaleDecorator] adds a red "On Sale!" label to the top left corner of the
final class OnSaleDecorator extends ProductCardDecorator {
  const OnSaleDecorator({required ProductCard productCard, Key? key})
      : super(productCard: productCard, key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        super.build(context),
        const Positioned(
          left: 10,
          top: 10,
          child: Text(
            "On Sale!",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
```

We apply the same similar operations in the **OutOfStockProductDecorator** Decorator. Our goal in this decorator is for the image of the product to have a slight opacity. In this way, the user will understand that the product is out of stock.

```dart
/// Concrete decorator class for featured products
/// [OutOfStockProductDecorator] adds a 50% opacity to the product card.
final class OutOfStockProductDecorator extends ProductCardDecorator {
  const OutOfStockProductDecorator({required ProductCard productCard, Key? key})
      : super(productCard: productCard, key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: super.build(context),
    );
  }
}
```

Finally, if the relevant product is a new product, we create an icon in the upper right corner of the product.

```dart
/// Concrete decorator class for new products
/// [NewProductDecorator] adds a yellow "New!" label to the top right corner of
final class NewProductDecorator extends ProductCardDecorator {
  const NewProductDecorator({required ProductCard productCard, Key? key})
      : super(productCard: productCard, key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        super.build(context),
        const Positioned(
          top: 0,
          right: 0,
          child: Icon(
            Icons.new_releases,
            color: Colors.orange,
            size: 30,
          ),
        ),
      ],
    );
  }
}
```

So how can we use this on the UI side? For example, we can use more than one decorator within reason.

```dart
class DecoratorView extends StatefulWidget {
  const DecoratorView({super.key});

  @override
  State<DecoratorView> createState() => _DecoratorViewState();
}

final class _DecoratorViewState extends State<DecoratorView> {
  @override
  Widget build(BuildContext context) {
    // simpleCard is a simple product card with an image, name, and price.
    const ProductCard simpleCard = SimpleProductCard(
      imageUrl: "https://picsum.photos/200",
      productName: "Example Product",
      price: 19.99,
    );

    // complesCard combines multiple decorators to create a complex product card.
    const ProductCard complexCard = OnSaleDecorator(
      productCard: NewProductDecorator(
        productCard: simpleCard,
      ),
    );

    // featureCard is a featured product card with opacity and a shadow.
    const ProductCard featureCard = OutOfStockProductDecorator(
      productCard: simpleCard,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: <Widget>[
          simpleCard.build(context),
          complexCard.build(context),
          featureCard.build(context),
        ],
      ),
    );
  }
}

```

<img src="https://user-images.githubusercontent.com/78795973/290292483-048dd72f-eb9c-49d9-bf5c-aa2f473e64b3.png" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="fecade">Fecade (Structural Patterns)</h2>
  The Facade design pattern is a structural design pattern used to manage complex systems with a simple interface. This pattern is used to facilitate the use of systems and hide their complexity. The Facade design pattern facilitates the understandability and use of code, especially in large software systems, by limiting direct access to subsystems and combining a set of subsystem functions into a single, high-level interface.

Facade enables complex subsystems to be exposed to the outside world through a simplified interface. Users can use these systems without having in-depth knowledge about the complex structures and functioning of the subsystems.

<h4 align="left">The Fecade design pattern has two main components</h4>

- **Fecade:** Provides the simplified interface presented to the outside world. It combines the functions of subsystems and presents them to the user.
- **Subsystems:** Classes that contain the complex functionality covered by the Facade interface. These are not called directly by the user, but are managed by the Facade class.

<h5 align="left">Advantages of the Fecade design pattern</h5>

- Enables the use of complex systems with a simpler interface.
- Reduces direct interaction with subsystems, making code easier to maintain and update.
- Facilitates testing of subsystems individually.

<h5 align="left"> Disadvantages of the Fecade design pattern</h5>

- An extra layer of abstraction can sometimes lead to performance loss.
- A very simplified interface can in some cases restrict access to all features of subsystems.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. As per our scenario, let's assume that we have more than one subsystem (Network layer) in our technical infrastructure. Let these be **WeatherService** for weather, **NewsService** for news, and **UserProfileService** for User. We can use these layers by collecting them in a single layer. Let's call this layer **ApiFacadeService**. We will use the **ApiFacadeService** layer to access other subsystems and use it in our operations. Let's place the main logic on the code, avoiding real data.

**WeatherService** has a method with the method signature `Future<Weather> getWeather()` and returns us the **Weather** model.

```dart
import 'package:design_patterns/patterns/fecade/model/weather.dart';

final class WeatherService {
  Future<Weather> getWeather() {
    return Future.value(Weather());
  }
}

```

**News Service** has a method with the method signature `Future<List<News>> get Latest News()` and returns us a list of the **News** model.

```dart
import 'package:design_patterns/patterns/fecade/model/news.dart';

final class NewsService {
  Future<List<News>> getLatestNews() {
    return Future.value(
      List.generate(
        10,
        (index) => News(),
      ),
    );
  }
}
```

**UserProfileService** has a method with the method signature `final class UserProfileService` and returns us the **UserProfile** model.

```dart
import 'package:design_patterns/patterns/fecade/model/user_profile.dart';

final class UserProfileService {
  Future<UserProfile> getUserProfile() {
    return Future.value(UserProfile());
  }
}

```

Now it's time to create the **ApiFacadeService** layer. We use the sublayers we want to use in this layer. In this way, we can use it by limiting access to the lower layers.

```dart
final class ApiFacadeService {
  final WeatherService _weatherService = WeatherService();
  final NewsService _newsService = NewsService();
  final UserProfileService _userProfileService = UserProfileService();

  Future<Weather> getWeather() => _weatherService.getWeather();
  Future<List<News>> getNews() => _newsService.getLatestNews();
  Future<UserProfile> getUserProfile() => _userProfileService.getUserProfile();
}
```

So how can we use this on the UI side? For example, **FutureBuilder** etc. You can use it in buildings.

```dart
final class FecadeView extends StatefulWidget {
  const FecadeView({super.key});

  @override
  State<FecadeView> createState() => _FecadeViewState();
}

class _FecadeViewState extends State<FecadeView> {
  ApiFacadeService? _apiFacadeService;

  @override
  void initState() {
    super.initState();
    _apiFacadeService = ApiFacadeService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _apiFacadeService != null
            ? FutureBuilder(
                future: _apiFacadeService!.getNews(),
                //! future: _apiFacadeService!.getUserProfile(),
                //! future: _apiFacadeService!.getWeather(),
                builder: (context, snapshot) => const Text("data"),
              )
            : const Text('an error occured'),
      ),
    );
  }
}
```

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="flyweight">Flyweight (Structural Patterns)</h2>
  The Flyweight design pattern is a structural design pattern used to optimize memory usage. This pattern aims to reduce repetitive states by separating intrinsic states and non-shareable states (extrinsic states) between objects, thus efficiently reducing memory usage. It becomes especially important in cases where many similar objects are created. An example of using the Flyweight design pattern in Flutter would be optimizing repeating widgets, especially in widget trees. In Flutter applications, some widgets are used repeatedly, especially in list or grid views. In this case, by applying the Flyweight pattern, we can optimize memory usage and improve the performance of the application.

<h4 align="left">The Flyweight design pattern has 4 main components</h4>

- **Flyweight Interface:** Defines a common interface of shared objects.
- **Concrete Flyweight:** Class that implements the Flyweight interface and stores the intrinsic state.
- **Flyweight Factory:** Creates and manages Flyweight objects. If the same object has been created before, it allows it to be reused.
- **Client:** Uses Flyweight objects. It provides the extrinsic state and combines it with Flyweight.

<h5 align="left">Advantages of the Flyweight design pattern</h5>

- Reduces memory usage by preventing similar objects from being created over and over again.
- Performance increases because fewer objects are created.

<h5 align="left"> Disadvantages of the Flyweight design pattern</h5>

- Design can get complicated.
- Management of internal and external situations may become difficult.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. According to our scenario, we want to make a social media application. Let's imagine a list showing posts in this application. Instead of creating the same icons over and over again for actions such as comments, likes and shares on each post, we will optimize them with the **Flyweight** design pattern.

First, we start by making the **Flyweight Interface** layer. We place a method with the method signature **Widget createWidget(Color color, double size)**, which returns **Widget**.

```dart
abstract class Flyweight {
  Widget createWidget(Color color, double size);
}
```

Then it's time for the **Concrete Flyweight** layer. We will store the **intrinsic state** in this layer. In our case, this will be an icon. At the same time, we **@override** the **createWidget** method by **implementing** the **Flyweight** layer.

```dart
final class IconFlyweight implements Flyweight {
    final IconData iconData;

    IconFlyweight(this.iconData);

    @override
    Widget createWidget(Color color, double size) {
        return Icon(iconData, color: color, size: size);
    }
}
```

It's time to create **Flyweight** objects in the **Flyweight Factory** layer. Here, if there is a previously created object, **icons** are pulled from the map. If it is an object that comes for the first time, it is added to the map.

```dart
final class IconFactory {
    final Map<IconData, IconFlyweight> _icons = {};

    IconFlyweight getIcon({required IconData iconData}) {
        if (!_icons.containsKey(iconData)) {
            _icons[iconData] = IconFlyweight(iconData);
        }
        return _icons[iconData];
    }
}
```

So how can we use this on the UI (**Client**) side?

```dart
final class FlyWeightView extends StatelessWidget {
  final IconFactory iconFactory = IconFactory();

  FlyWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemBuilder: (context, index) {
                final post = SocialMediaPost(
                  title: 'Post $index',
                  content:
                      '-$index Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                );

                return ListTile(
                  leading: iconFactory
                      .getIcon(iconData: Icons.account_circle)
                      .createWidget(Colors.blue, 24.0),
                  title: Text(post.title),
                  subtitle: Text(post.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      iconFactory
                          .getIcon(iconData: Icons.comment)
                          .createWidget(Colors.grey, 20.0),
                      const SizedBox(width: 8),
                      iconFactory
                          .getIcon(iconData: Icons.thumb_up)
                          .createWidget(Colors.grey, 20.0),
                      const SizedBox(width: 8),
                      iconFactory
                          .getIcon(iconData: Icons.share)
                          .createWidget(Colors.grey, 20.0),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

```

Each of the 10 listtiles contains 4 different icons. Under normal conditions, 40 icon objects of 4x10 would be produced, but thanks to **Flyweight**, this number decreased to 4, that is, the number of different icons.

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/72f1007d-a5fc-4f1d-b3f9-215dc7bcf365" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/b5a1d964-e308-4445-8a8e-6f2965cb140a" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="proxy">Proxy (Structural Patterns)</h2>
  A proxy design pattern is a structural design pattern used to control access to an object or to make this access through another object. While this pattern is used to extend or modify the functionality of an object, it operates without changing the structure of the original object. The proxy serves as a kind of interface or representative to the real object.

<h4 align="left">The proxy design pattern has three main components</h4>

- **Subject Interface:** The actual object and the interface that the proxy should implement.
- **Real Subject:** The actual object that the client wants to access.
- **Proxy:** An object that controls access to or replaces the real object.

<h5 align="left">Advantages of proxy design pattern</h5>

- Proxy allows you to control access to real objects. For example, you can add security controls or access permissions.
- Can improve the performance of the application by delaying the loading of expensive resources. It is especially useful for large objects or data coming over the network.
- It can increase performance by reducing unnecessary network traffic, especially when retrieving data from remote servers. For example, by caching data, it can prevent the same data from being loaded repeatedly.
- The proxy can log operations performed on the real object and add extra layers of security.
- Users or other objects can interact with real objects without being aware of the existence of the proxy.

<h5 align="left"> Disadvantages of proxy design pattern</h5>

- Implementation of proxy pattern can increase the overall complexity of the system. For simple cases, this extra complexity may be unnecessary.
- Proxy class may create extra processing load in some cases. In particular, going through a proxy on every request can increase processing time.
- Proper management of the proxy is necessary, especially if features such as caching or security have been added. A mismanaged proxy can lead to data inconsistency or security vulnerabilities.
- Implementing the proxy pattern correctly can make the design difficult to understand and extend in some cases.
- The layers added by the proxy can make testing processes more complex in some cases.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. As a real-life scenario in Flutter, a proxy can be used to access a remote API. For example, when an application is pulling data from a remote server, it can use a proxy to manage these requests and add a caching mechanism if necessary. Let's assume we are using a **Weather** API in this scenario.

First of all, we create an **interface** named **WeatherSerice** as **Subject Interface**. This interface has a method called **getWeatherData** to retrieve data from the API. We will implement this layer to the original object and the proxy layer.

```dart
abstract class WeatherService {
    Future<String> getWeatherData();
}
```

Then, we implement the **Subject Interface** while writing a **Real Subject** layer named **WeatherApiService**.

```dart
final class WeatherApiService implements WeatherService {
    @override
    Future<String> getWeatherData() async => 'Sunny, 25°C';
}
```

Now it's time for the **Proxy** layer, which is the key point of the **Proxy Design Pattern**. The proxy layer captures API requests and, if necessary, adds a cache mechanism or logs the requests.

```dart
final class WeatherServiceProxy implements WeatherService {
    final WeatherApiService _weatherApiService = WeatherApiService();
    String _cachedData;

    @override
    Future<String> getWeatherData() async {
        if (_cachedData == null) {
            print('Fetching data from API...');
            _cachedData = await _weatherApiService.getWeatherData();
        } else {
            print('Returning cached data...');
        }
        return _cachedData;
    }
}

```

So how can we use this? In this example, the WeatherServiceProxy class controls the data retrieval from the API and caches the data. In the first request, it accesses the real API and retrieves the data, and in subsequent requests it uses the cached data. This approach can improve performance and reduce network traffic, especially in situations where the same data is needed frequently. The proxy design pattern provides an efficient solution in such scenarios. In our case, we will assign the data pulled 5 times to the cache after it is pulled for the first time, and we will quickly obtain the answers to the remaining 4 requests from the cache. In this way, we will not be loaded with unnecessary network traffic.

```dart

final class ProxyView extends StatelessWidget {
  final IWeatherService _weatherService = WeatherServiceProxy();

  ProxyView({super.key});

  Future<String> getWeatherFiveTimes() async {
    var results = [];

    for (var i = 0; i < 5; i++) {
      var data = await _weatherService.getWeatherData();
      results.add(data);
    }
    return results.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: getWeatherFiveTimes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Veriyi ekranda göster
              return Text('Weather: ${snapshot.data}');
            }
          },
        ),
      ),
    );
  }
}
```

[Return to the beginning of the documentation](#head)

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/8db12fb1-b5ba-44b7-be36-8040afe72990" width="250">
<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/27fed6e3-eb3a-4161-a893-cee09d291f27" width="250">

- <h2 align="left"><a id="chainofresponsibility">Chain of Responsibility (Behavioral Patterns)</h2>
    Let's discuss the Chain of Responsibility design pattern in Flutter in more detail. This pattern is useful for managing incoming requests or commands across different widgets or screens, especially in large and modular Flutter applications.
  <h4 align="left">The Chain of Responsibility design pattern has three main components</h4>

- **Handler:** An interface that defines how to process the request and pass the request to the next handler in the chain.
- **Concrete Handlers:** Classes that implement the Handler interface. Each processor decides whether to process the request or pass it to the next processor in the chain.
- **Client:** The person or system that initiates the request and sends it to the first handler of the chain.

<h5 align="left">Working Mechanism</h5>

- The client sends the request to the first handler in the chain.
- Each processor checks the request and decides whether to process it or not.
- If a handler can process the request, it performs the action and the process ends.
- If the handler cannot process the request, it forwards it to the next handler in the chain.
- This process continues until a handler processes the request or the chain ends.

<h5 align="left">Advantages of the Chain of Responsibility design pattern</h5>

- Sender and receiver become independent, encouraging loose coupling in the system.
- Easy to add new handlers or change the order of existing ones.
- Each handler has a single responsibility, making the code easier to maintain.

<h5 align="left"> Disadvantages of proxy design pattern</h5>

- The request may pass through multiple processors, which may impact performance.
- Can be difficult to debug because the request passes through various handlers.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. Consider a Flutter application that processes different types of user input (gestures, button clicks, text input). The application can use the Chain of Responsibility model to process these inputs.

The **Handler** interface, which forms the basis of the Chain of Responsibility pattern, defines the basic methods that each **Concrete Handlers** class must implement. In Flutter, this is usually done in the form of an abstract class. In our case, **InteractionHandler** will be our **Handler** **abstarct** class. This abstract class will be inherited by **Concrete Handlers**'s. **setNextHandler** will be a method to establish connections between chains. In this way, when an incompatible situation occurs, the next chain will run.

```dart
/// [CommandHandler] is the abstract class for all the handlers.
abstract class InteractionHandler {
  InteractionHandler? nextHandler;

  void handleInteraction(String interactionType, BuildContext context);

  void setNextHandler(InteractionHandler handler) {
    nextHandler = handler;
  }
}
```

Then we define our **Concrete Handlers** classes. In our case, we are writing 2 different **Concrete Handlers** classes, **ButtonInteractionHandler** and **FormInteractionHandler**, as an example. If **ButtonInteractionHandler** from these classes is used, we want to display an **AlertBox** on the screen as per the scenario. If the **FormInteractionHandler** class is used, we want to print the _Form submitted_ log by submitting. If **interactionType** is not found, we provide relevant information by running the **handleUnrecognizedInteraction** method.

```dart
/// [ButtonInteractionHandler] is a concrete handler.
final class ButtonInteractionHandler extends InteractionHandler {
  @override
  void handleInteraction(String interactionType, BuildContext context) {
    if (interactionType == 'buttonClick') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Button Clicked"),
            content: Text("Button interaction handled."),
          );
        },
      );
    } else if (nextHandler != null) {
      nextHandler!.handleInteraction(interactionType, context);
    } else {
      handleUnrecognizedInteraction(interactionType, context);
    }
  }
}

/// [FormInteractionHandler] is a concrete handler.
final class FormInteractionHandler extends InteractionHandler {
  @override
  void handleInteraction(String interactionType, BuildContext context) {
    if (interactionType == 'formSubmit') {
      // Form submit logic
      log("Form submitted.");
    } else if (nextHandler != null) {
      nextHandler!.handleInteraction(interactionType, context);
    } else {
      handleUnrecognizedInteraction(interactionType, context);
    }
  }
}
```

So, in what scenario can we use this on the UI side? Let's assume we have 3 buttons: **Click Me**, **Submit Form** and **Unknown**. First of all, we create a **ButtonInteractionHandler** and set its **interactionType** to **buttonClick**. The purpose of this button is to display an **AlertDialog** if **buttonClick** exists. If **interactionType** is not technically supported in the current handler, the next handler will be processed. If **interactionType** is not supported at all, we notify the user with **handleUnrecognizedInteraction**.

```dart
/// [ChainOfResponsibilityView] is the view that shows the Chain of Responsibility Pattern.
final class ChainOfResponsibilityView extends StatefulWidget {
  const ChainOfResponsibilityView({super.key});

  @override
  State<ChainOfResponsibilityView> createState() => _ChainOfResponsibilityViewState();
}

class _ChainOfResponsibilityViewState extends State<ChainOfResponsibilityView> {
  @override
  Widget build(BuildContext context) {
    var buttonHandler = ButtonInteractionHandler();
    var formHandler = FormInteractionHandler();

    buttonHandler.setNextHandler(formHandler);

    return Scaffold(
      appBar: AppBar(title: const Text("Chain of Responsibility in Flutter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => buttonHandler.handleInteraction('buttonClick', context),
              child: const Text('Click Me'),
            ),
            ElevatedButton(
              onPressed: () => buttonHandler.handleInteraction('formSubmit', context),
              child: const Text('Submit Form'),
            ),
            ElevatedButton(
              onPressed: () => buttonHandler.handleInteraction('unknown', context),
              child: const Text('unknown'),
            ),
          ],
        ),
      ),
    );
  }
}
```

Clicking buttons from top to bottom

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/a7c5ad17-3eca-4382-84cb-3350ca789a70" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/9549a990-f535-47ba-a93c-9acd0cf8983e" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/78626739-f4df-4929-8c2c-3c47bb45643c" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="iterator">Iterator(Creational Patterns)</h2>
  The Iterator pattern is a behavioral design pattern that allows sequential access to the elements of a collection (such as a list or tree) without revealing its underlying structure. This pattern separates the iteration logic from the collection, providing a standard way to traverse the collection.

<h4 align="left">Iterator design pattern has 4 main components</h4>

- **Iterator:** Defines standard operations required for iteration such as next(), hasNext().
- **Concrete Iterator:** Implements the Iterator interface and keeps track of the current position in the collection.
- **Aggregate:** Defines an interface for creating an Iterator object.
- **Concrete Aggregate:** Implements the Aggregate interface and returns an instance of the corresponding Concrete Iterator.

<h5 align="left">Advantages of Iterator design pattern</h5>

- Single Responsibility Principle: Separates the responsibility of iterating over a collection from the collection itself.
- Flexibility: Different types of iterators can be implemented to support different iteration strategies.
- Independence: Client code interacts with the collection through the iterator interface, reducing its dependence on the form of the collection.

<h5 align="left"> Disadvantages of Iterator design pattern</h5>

- Can complicate code, especially for simple collections that can be iterated using simple loops.
- If not implemented effectively, it can create additional burden on performance.
  **Sample Scenario**

For example, consider a photo gallery app that displays images in a carousel. Images can be stored in a list and an iterator can be used to display each image. In this case, we will use **Iterator Design Pattern** to show the images to the user using **moveNext()**.

First of all, we create the photo model that we will show in the gallery and assume that each photo has a URL.

```dart
/// [Photo] is a simple model class that holds the url of a photo.
@immutable
final class Photo {
  final String url;
  const Photo(this.url);
}
```

Next, we write the **Aggregate** component named **PhotoCollection**.
**PhotoCollection** represents the collection itself, **getIterator**() represents the **Iterator** member, the ability to create Iterator.

```dart
/// [PhotoCollection] is the Concrete Aggregate.
final class PhotoCollection {
  final List<Photo> _photos = [];

  void addPhoto(Photo photo) {
    _photos.add(photo);
  }

  /// [getIterator] returns an iterator for the collection.
  Iterator<Photo> getIterator() => _photos.iterator;

  int get length => _photos.length;
}
```

Then, we obtain a concrete application by implementing the **Iterator<Photo>** class to our **Concrete Iterator** component. As a result, we enable us to display photos by containing the logic necessary to navigate through the collection.

```dart
/// [PhotoIterator] is Concrete Iterator
final class PhotoIterator implements Iterator<Photo> {
  final List<Photo> _photos;
  int _current = 0;

  PhotoIterator(this._photos);

  @override
  Photo get current => _photos[_current];

  @override
  bool moveNext() {
    if (_current < _photos.length - 1) {
      _current++;
      return true;
    }
    return false;
  }
}

```

So how can we use this on the UI side? First of all, we create a view page named **IteratorView**. We display our images by iterating using GridView.builder.

```dart
/// [IteratorView] is Iterator View.
final class IteratorView extends StatelessWidget {
  final PhotoCollection photos;

  const IteratorView({required this.photos, super.key});

  @override
  Widget build(BuildContext context) {
    var iterator = photos.getIterator();

    return Scaffold(
      appBar: AppBar(title: const Text("Iterator in Flutter")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          if (iterator.moveNext()) {
            return Image.network(iterator.current.url);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

```

Since **IteratorView** takes the _PhotoCollection_ parameter, we add the urls of the images first.

```dart
PhotoCollection()
          ..addPhoto(
            const Photo('https://picsum.photos/200'),
          )
          ..addPhoto(
            const Photo('https://picsum.photos/200'),
          )
          ..addPhoto(
            const Photo('https://picsum.photos/200'),
          )
          ..addPhoto(
            const Photo('https://picsum.photos/200'),
          ),
```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/2d48efc0-9950-491b-a060-5fd7f192e384" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="interpreter">Interpreter (Behavioral Patterns)</h2>
  The Interpreter design pattern is a behavioral design pattern that allows us to define a grammar for a language and provide an interpreter that processes expressions in that language.

<h4 align="left">The Interpreter design pattern has 4 main components</h4>

- **Expression Interface:** This interface declares a method of interpreting a particular context. It is the core of the interpreter pattern.
- **Concrete Expression Classes:** These classes implement the Expression interface and interpret specific rules in the language.
- **Context Class(optional):** This class contains general information about the interpreter.
- **Client:** The client creates the syntax tree representing a particular sentence that defines the grammar of the language. The tree consists of instances of Concrete Expression classes.

<h5 align="left">Advantages of the Interpreter design pattern</h5>

- Grammar rules and interpreters can be easily changed and new expressions added as needed.
- It ensures that the code is modular and reusable.
- Can be optimized for processing complex expressions.

<h5 align="left"> Disadvantages of the Interpreter design pattern</h5>

- Developing interpreters for complex languages can be difficult.
- For simple expressions the interpreter may be slower than direct code.

**Sample Scenario**

Under normal circumstances, **Interpreter Design Pattern** is used more in _programming languages_, _SQL queries_, _Mathematical expressions_, _Game engines_, but since our current focus is **Flutter**, **Interpreter Design Pattern** is based on **Flutter Framework**. We will try to use it. For our scenario, let's consider a mobile application that allows users to define customizable widget structures using a text-based language. Users can dynamically build their interfaces using a simple language that specifies specific widget types, features, and layouts. For example, a user may want to show text by typing something like `"Text: Deatsilence"` or they might want to show an image by typing `"Image: https://picsum.photos/200"`.

First, we define an **Expression Interface** named **WidgetExpression**. We write a method signature called _interpret()_ in **WidgetExpression** that returns a Widget. This interface will be implemented by **Concrete Expression** classes.

```dart
/// [WidgetExpression] is the interface for the expression
abstract class WidgetExpression {
  Widget interpret();
}
```

Afterwards, we create two **Concrete Expression Class** named **ConcreteExpressionText** and **ConcreteExpressionImage** and implement the abstract class named **WidgetExpression**. We _override_ the _interpret_ method in the **Concrete Expression** classes and return **Text or Image** according to the text script received from the user. We can do this for other Widgets as well, but according to our scenario, we continue with these two specifically.

```dart
/// [ConcreteExpressionText] is the concrete expression for the text
final class ConcreteExpressionText implements WidgetExpression {
  final String text;
  final TextStyle style;

  ConcreteExpressionText({required this.text, required this.style});

  @override
  Widget interpret(BuildContext? context) => Text(text, style: style);
}

/// [ConcreteExpressionButton] is the concrete expression for the button
final class ConcreteExpressionImage implements WidgetExpression {
  final String url;

  ConcreteExpressionImage({
    required this.url,
  });

  @override
  Widget interpret(BuildContext? context) => Image.network(url, width: 100, height: 100);
}
```

Then, we add a method called **parseScript()** into the **WidgetParser** class to interpret the scripts coming from the user.

```dart
final class WidgetParser {
  List<WidgetExpression> parseScript(String script) {
    List<WidgetExpression> expressions = [];
    for (String line in script.split('\n')) {
      line = line.trim();
      if (line.isEmpty) continue;

      /// for example: Text("Hello World")
      if (line.startsWith("Text:")) {
        String text = line.substring(5, line.length);
        expressions.add(
          ConcreteExpressionText(
            text: text,
            style: const TextStyle(fontSize: 20),
          ),
        );
        continue;
      }

      /// for example: Image:https://example.com/image.png
      if (line.startsWith("Image:") && line.contains("https://")) {
        String url = line.substring(6, line.length);
        debugPrint(url);
        List<String> parts = url.split(',');
        String urlTrimmed = parts[0].trim();
        expressions.add(ConcreteExpressionImage(url: urlTrimmed));
        continue;
      }
    }
    return expressions;
  }
}
```

Finally, how can we use them on the UI side? Let's look at it. For example, let's interpret some scripts from the user via a **TextField**. Let's show the image or text to the user as a result of the interpretation.

```dart

final class InterpreterView extends StatefulWidget {
  const InterpreterView({super.key});

  @override
  State<InterpreterView> createState() => _InterpreterViewState();
}

class _InterpreterViewState extends State<InterpreterView> {
  String? _script;
  List<WidgetExpression>? _expressions;

  @override
  void initState() {
    super.initState();
    _script = "";
    _expressions = WidgetParser().parseScript(_script ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interpreter Pattern"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: _script),
              onChanged: (value) {
                _script = value;
              },
              decoration: const InputDecoration(
                labelText: "Command Script",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _expressions = WidgetParser().parseScript(_script ?? "");
                setState(() {});
              },
              child: const Text("Comment the script"),
            ),
            const SizedBox(height: 16.0),
            if (_expressions != null && _expressions!.isNotEmpty)
              _expressions!.first.interpret(context),
          ],
        ),
      ),
    );
  }
}

```

- When the user sees any text following the **Text:** keyword to display text, the relevant text will be displayed on the screen.

- To display an image, the user must provide a url followed by the **Image:** keyword. It will display the image found in the URL on the screen.

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/1323d690-0800-4599-b4a0-520d6827c655" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/5cf8b3ba-e99f-43e9-8ece-596b4daf9459" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="observer">Observer(Behavioral Patterns)</h2>
  The Observer design pattern is a powerful tool for managing state changes in your Flutter applications. It creates a reactive and efficient system by establishing a communication system that notifies multiple connected objects (Observers) when there is a change in the state of an object (Subject).

<h4 align="left">The Observer design pattern has two main components</h4>

- **Subject:** This component is the object to which observers subscribe and informs them about state changes. The topic provides an interface that keeps track of any changes to the data it contains and notifies observers of these changes.
- **Observer:** Observers are objects that monitor and react to changes in the subject's state. These objects usually implement an interface (Observer Interface), and this interface contains methods that are called when the state of the object changes.
- **Client:** This component handles application logic using the Observer design pattern. The client typically creates topic objects, subscribes observers to those topics, and updates the status of the topic.

<h5 align="left">Advantages of the Observer design pattern</h5>

- The Observer pattern provides a weak connection between the subject and the observers. This means changing one does not directly affect the other, making maintenance and expansion of the application easier.
- The same observer can follow different topics and a topic can have more than one observer. This flexibility increases code reusability.
- Observers can subscribe and unsubscribe from topics at runtime. This supports dynamic and changing application requirements.
- The Observer pattern provides modularity by abstracting different parts of the application. This increases the readability and manageability of the code.

<h5 align="left"> Disadvantages of the Observer design pattern</h5>

- If connections between observers and subjects are not managed properly, it can lead to memory leaks. In particular, forgetting to unregister observers can cause this problem.
- If there are many observers or notifications are made too frequently, performance issues may occur. Processing load may increase as each notification requires all observers to react.
- If a topic makes many updates in a short period of time, observers need to constantly react to these updates. This can lead to unexpected behavior.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. For our scenario, let's assume that there are 2 different food types in the basket, 1 **Food1** and 1 **Food2** by default, and let's imagine that I increase or decrease the number of these dishes in the basket. **Total Price** may increase or decrease depending on the situation.

First, we define our **Subject** component, that is, the **State** components and methods that **Observer** will listen to, along with the **Mobx** package on the Flutter side. We write down the methods for increasing and decreasing the amount for each meal. On the UI side, changing the variables that **Observer** will listen to with **@observable** annotation, variables labeled with **@action** and **@observable**, and redrawing the parts surrounded by **Observer** on the UI side. We provide.

```dart
@immutable
final class Item {
  final String id;
  final String name;
  final double price;
  final String image;
  final int quantity;

  const Item({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  Item copyWith({
    String? id,
    String? image,
    String? name,
    double? price,
    int? quantity,
  }) {
    return Item(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

```

```dart
import 'package:design_patterns/patterns/observer/model/item.dart';
import 'package:mobx/mobx.dart';

part 'observer.g.dart';

final class ShoppingItemsStore = ShoppingItemsStoreBase with _$ShoppingItemsStore;

abstract class ShoppingItemsStoreBase with Store {
  /// The list of items that the user had added to the cart.
  @observable
  ObservableList<Item> items = ObservableList.of(
    [
      const Item(
        id: '1',
        image: 'https://picsum.photos/200',
        name: 'Food 1',
        price: 10.0,
      ),
      const Item(
        id: '2',
        image: 'https://picsum.photos/200',
        name: 'Food 2',
        price: 20.0,
      ),
    ],
  );

  @observable
  double totalPrice = 30.0;

  /// [increase] Increases the quantity of the item by 1.
  @action
  void increase(Item item, int index) {
    if (!items.contains(item)) {
      items.add(item);
    }

    items[index] = item.copyWith(quantity: item.quantity + 1);
    totalPrice += item.price;
  }

  /// [decrease] Decreases the quantity of the item by 1.
  @action
  void decrease(Item item, int index) {
    if (items.contains(item) && items[index].quantity >= 1 && totalPrice >= item.price) {
      totalPrice -= item.price;

      items[index] = item.copyWith(quantity: item.quantity - 1);
      if (items[index].quantity == 0) {
        items.remove(item);
      }
    }
  }
}

```

So how can we use this on the UI side? As I mentioned before, we increase or decrease the number of dishes in the basket and update the total amount accordingly. If variables tagged with **@observable** are updated with **@action**, it redraws the widget tree wrapped in **Observable** on the UI side.

```dart
final class ObserverView extends StatefulWidget {
  const ObserverView({super.key});

  @override
  State<ObserverView> createState() => _ObserverViewState();
}

class _ObserverViewState extends State<ObserverView> {
  late final ShoppingItemsStore _store;

  @override
  void initState() {
    super.initState();
    _store = ShoppingItemsStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observer'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: double.infinity,
          child: Observer(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _store.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _Food(store: _store, index: index);
                  },
                ),
                const SizedBox(height: 20),
                Text('Total Price: ${_store.totalPrice}'),
              ],
            );
          }),
        ),
      ),
    );
  }
}


final class _Food extends StatelessWidget {
  const _Food({
    super.key,
    required ShoppingItemsStore store,
    required this.index,
  }) : _store = store;

  final ShoppingItemsStore _store;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_store.items[index].name),
      subtitle: Text("Price: ${_store.items[index].price}"),
      leading: Image.network(_store.items[index].image),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              _store.decrease(_store.items[index], index);
            },
          ),
          Text('${_store.items[index].quantity}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _store.increase(_store.items[index], index);
            },
          ),
        ],
      ),
    );
  }
}
```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/8a57831f-5c57-4c7d-a253-0c0d2558a1e7" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/ce28b883-156c-4369-a45b-fe946b390af4" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/1b82506b-b915-4427-968f-3b9ea43f67c7" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="command">Command (Behavioral Patterns)</h2>
  Command pattern is a pattern frequently used in software engineering, especially object-oriented programming. This pattern allows encapsulating a request or action as an object. The main purpose of this approach is to create an abstraction layer between the code that performs operations and the code that calls these operations.

<h4 align="left">The Command design pattern has two main components</h4>

- **Command Interface:** Create an interface that all commands will implement. It usually contains a single execute() method.
- **Concrete Command:** Create classes that implement the command interface and perform a specific operation.
- **Invoker:** Triggers commands. For example, a button can take on this role.
- **Receiver:** The object on which the command actually does the work. For example, a class that performs a specific operation within an application.
- **Client:** Creates the command object and assigns it to the caller.

<h5 align="left">Advantages of the Command design pattern</h5>

- Commands can be reused in different contexts.
- Provides a clear separation between UI and business logic.
- New commands can be added easily.
- It makes writing unit tests easier because each command contains separate functionality that can be tested independently.

<h5 align="left"> Disadvantages of the Command design pattern</h5>

- It may be too complex for simple operations.
- Extra classes may be required for each new command, which can bloat the code base.

**Sample Scenario**
Let's create a simple text editor in a Flutter application. As the user edits text, each editing action will be recorded as a command, providing undo and redo functions.

First, we start by writing the **Command Interface** component named **TextCommand**.

```dart
/// [TextCommand] is the abstract class for the Command Pattern.
abstract class TextCommand {
  void execute();
  void undo();
}
```

Then we write your **Concrate Command** component named **UpdateTextCommand**. **TextCommand** **Abstract** class is implemented in this component. This class will be used to keep track of new and old text statuses.

```dart
/// [UpdateTextCommand] is the concrete class for the Command Pattern.
final class UpdateTextCommand implements TextCommand {
  final TextEditingController controller;
  final String newText;
  String oldText;

  UpdateTextCommand(this.controller, this.newText) : oldText = controller.text;

  @override
  void execute() {
    controller.text = newText;
  }

  @override
  void undo() {
    controller.text = oldText;
  }
}
```

It's time to write the **Invoker** component named **TextEditorController**. **Invoker** will be used to manage transaction history. For this, it will use methods such as **undo()**, **redo()**.

```dart
/// [TextEditorController] is the Invoker class for the Command Pattern.
final class TextEditorController {
  final List<TextCommand> _commandHistory = [];
  int _currentCommandIndex = -1;

  void executeCommand(TextCommand command) {
    if (_currentCommandIndex != _commandHistory.length - 1) {
      _commandHistory.removeRange(_currentCommandIndex + 1, _commandHistory.length);
    }
    _commandHistory.add(command);
    _currentCommandIndex++;
    command.execute();
  }

  void undo() {
    if (_currentCommandIndex >= 0) {
      _commandHistory[_currentCommandIndex].undo();
      _currentCommandIndex--;
    }
  }

  void redo() {
    if (_currentCommandIndex < _commandHistory.length - 1) {
      _currentCommandIndex++;
      _commandHistory[_currentCommandIndex].execute();
    }
  }
}
```

So how can we use this on the UI side? By creating a **TextField** for this. We will perform these operations with the **Undo**, **Redo** buttons.

```dart

/// [CommandView] is the view that shows the Command Pattern.
final class CommandView extends StatelessWidget {
  final TextEditorController controller = TextEditorController();
  final TextEditingController textEditingController = TextEditingController();

  CommandView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Command Pattern in Flutter')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              onChanged: (text) {
                controller.executeCommand(UpdateTextCommand(textEditingController, text));
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.undo();
            },
            child: const Text('Undo'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.redo();
            },
            child: const Text('Redo'),
          ),
        ],
      ),
    );
  }
}

```

The first image shows the entered text, the second image shows the situation after pressing the **Undo** button once, and the third image shows the situation after pressing the **Redo** button once.

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/f65a1529-5e6a-4496-bee2-0fd0538f643f" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/d6eabff6-2d9c-446b-bd1c-2a9e5723c795" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/f65a1529-5e6a-4496-bee2-0fd0538f643f" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="mediator">Mediator (Behaverioal Patterns)</h2>
  Mediator Design Pattern is a behavioral design pattern that regulates communication and interaction between objects in software. Its main purpose is to reduce tight dependencies between objects and create a more modular code structure.

  Mediator Design Pattern is used to facilitate communication between components in Flutter. This model allows components to communicate through a mediator rather than communicating directly with each other. This approach makes the code easier to maintain and extend because it reduces coupling between components.

<h4 align="left">The Mediator design pattern has two main components</h4>

- **Mediator Interface::** Create an interface that all mediators must comply with. This interface provides a common set of methods by which components can communicate.
- **Concrete Mediator:** Class that implements the Mediator interface and coordinates communication between components.
- **Colleagues:** Components that use mediator to communicate with each other.

<h5 align="left">Advantages of the Mediator design pattern</h5>

- Reduced Complexity: Mediator handles complex communication between many small components. This reduces the overall complexity in the system.
- Loose Coupling: Components communicate not directly with each other, but through the mediator. This allows components to be more independent and makes the code easier to maintain.
- Central Control Point: Since all communication goes through a central point, you can easily monitor and change the application's behavior and communication.
- Reusability: Mediator and individual components can be reused in different scenarios when properly designed.
- Easy Extensibility: Adding new components usually only requires updating the mediator, making system expansion easier.

<h5 align="left"> Disadvantages of the Mediator design pattern</h5>

- Mediator Overload: Since all communication goes through a central point, the mediator can take on too much responsibility and become complicated.
- Performance Issues: All communication through Mediator can cause performance issues on large systems.
- Dependency Issues: The dependency of components on the mediator may require the components to be updated if the mediator changes.
- For small or simple applications, the mediator design pattern can add unnecessary complexity.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. Let's conduct a survey as per our scenario. This app will feature various question widgets and a results display widget. Question widgets collect the user's answers and transmit this information to the result widget via mediator.

First, let's start by writing our **Mediator Interface** component named **SurveyMediator**. We define method signature **submitAnswer(String question, String answer)**. This **abstract** class will help us communicate between the survey and results display widgets.

```dart
/// [SurveyMediator] is the mediator interface
abstract class SurveyMediator {
  void submitAnswer(String question, String answer);
}
```

Afterwards, we create our **Concrete Mediator** component named **SurveyManager**. This component implements the **SurveyMediator** component and coordinates the communication between components. In our case, we assign answers for each question to the _responses_ map by _@override_ the **submitAnswer(String question, String answer)** method in **SurveyManager**.

```dart
/// [SurveyManager] is the concrete mediator
final class SurveyManager extends ChangeNotifier implements SurveyMediator {
  final Map<String, String> responses = {};

  @override
  void submitAnswer(String question, String answer) {
    responses[question] = answer;
    notifyListeners();
  }
}
```

It's time to create our **Colleagues** component named **QuestionWidget**. As mentioned before, this class is a component that uses mediator to communicate with each other. Each **QuestionWidget** component contains one question and one answer.

```dart
/// [QuestionWidget] is a widget that is a colleague in the mediator pattern.
final class QuestionWidget extends StatelessWidget {
  final String question;

  const QuestionWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(question),
          TextField(
            onChanged: (answer) {
              Provider.of<SurveyManager>(context, listen: false)
                  .submitAnswer(question, answer);
            },
          ),
        ],
      ),
    );
  }
}
```

So how can we use this on the UI side? For example, let's say we have 2 questions. We will use **QuestionWidget** for each question. Let's print the current answer and question on the console every time we press the button.

```dart
/// [MediatorView] is a widget that is a view in the mediator pattern.
final class MediatorView extends StatelessWidget {
  const MediatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mediator Design Pattern')),
      body: Column(
        children: [
          const QuestionWidget(question: "What is your favorite color ?"),
          const SizedBox(height: 10),
          const QuestionWidget(question: "What is your favorite meal ?"),
          ElevatedButton(
            onPressed: () => log(
                Provider.of<SurveyManager>(context, listen: false).responses.toString()),
            child: const Text('Show The Results'),
          ),
        ],
      ),
    );
  }
}
```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/35d6419d-c084-4490-b290-3e3184bc3cd0" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/216b8558-2b8a-4f5d-a9c0-23f1bb0d7949" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="state">State (Behaverioal Patterns)</h2>
  State design pattern is a structural design pattern used to manage the states of widgets in Flutter. This pattern allows to manage these changes efficiently and clearly when the states of widgets change. Now let's examine this pattern step by step and discuss the advantages and disadvantages of this pattern with a real scenario in the Flutter framework.

<h4 align="left">The Mediator design pattern has two main components</h4>

- **Stateful and Stateless Widgets:** There are two basic types of widgets in Flutter: Stateless and Stateful. Stateless widgets show fixed (unchanging) data, while Stateful widgets show variable data and can update it.
- **Make a Stateful Widget:** A Stateful widget usually consists of two classes: First, a widget class derived from the StatefulWidget class; The second is a state class derived from the State class.
- **State Object:** class holds the state of the widget. This class contains methods that manage the widget's data and changes made to this data.
- **build Method:** class maintains the state of the widget. This class contains methods that manage the widget's data and changes made to this data.
- **setState Method:** When the state changes, the setState method is used. This method notifies the Flutter framework of state changes and causes the build method to run again.

<h5 align="left">Advantages of the Mediator design pattern</h5>

- Flexibility and Reuse: Stateful widgets can change dynamically based on their state, making them reusable and flexible.
- Clear Code Structure: Separation of state and interface makes the code more understandable and manageable.

<h5 align="left"> Disadvantages of the Mediator design pattern</h5>

- Performance: Each setState call causes the widget to be rebuilt, which can lead to unnecessary render operations.
- Complexity: In small and simple applications, using Stateful widgets can lead to unnecessary complexity.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. In our scenario, let's say you are building a shopping application and you have a widget that shows the number of items in the user's cart. Every time the user adds a new product, this number needs to be updated. Here you can dynamically update the number of carts using StatefulWidget.

First, we create a **StateFul Widget** named **CardWidget**. Next, we create a private class named **\_CartWidgetState**, which inherits from the **State** class. We want it to create the **\_CartWidgetState** class as a state by _@override_ the _createState_ method of the **StateFul** widget. Then, we can increase or decrease the current _itemCount_ variable by using the _setState_ method. In this way, we completely update the entire **CartWidget**, but this will cause a big performance problem in large and branched widget trees. That's why I recommend you look at the current **State** methods. There is no harm in using the _setState_ method on small widgets.

```dart
/// [CartWidget] is a widget that is a colleague in the mediator pattern.
final class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int itemCount = 0;

  void addItem() {
    setState(() {
      itemCount++;
    });
  }

  void removeItem() {
    setState(() {
      itemCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Amount of product in basket: $itemCount'),
              OutlinedButton(
                onPressed: addItem,
                child: const Text('Add Product to Basket'),
              ),
              OutlinedButton(
                onPressed: removeItem,
                child: const Text('Remove Product from Basket'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

I'm returning **CartWidget** in **StateView** to use on the UI side.

```dart

/// [StateView] is a widget that is a view in the state pattern.
final class StateView extends StatelessWidget {
  const StateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CartWidget();
  }
}
```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/baa72dfb-7f19-4bed-9770-9c8aee033c4d" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/b52b7781-82bc-4e78-9ade-75d94bb2b8d9" width="250">

[Return to the beginning of the documentation](#head)

- <h2 align="left"><a id="strategy">Strategy (Behaverioal Patterns)</h2>
  A strategy design pattern is a software design pattern that allows objects to change their behavior at runtime. In Flutter, this pattern is often used to manage different widget behaviors. Below is a step-by-step explanation and real-life scenario on how to implement the Strategy pattern in Flutter.

<h4 align="left">The Strategy design pattern has three main components</h4>

- **Context:** It is the class that depends on and contains the strategy to be used. It acts as the interface between the rest of the application and the strategy. It stores and manages which strategy will be used during execution.
- **Strategy Interface:** It is an interface or abstract class that all strategies must implement. This interface defines the methods that each strategy class will implement.
- **Concrete Strategies:** These are classes that implement the Strategy interface or abstract class. These classes implement methods defined in the interface and contain specific algorithms used by Context.

<h5 align="left">Advantages of the Strategy design pattern</h5>

- Flexibility and Adaptability to Change: The strategy model allows you to easily change different algorithms or behaviors. This allows you to dynamically adjust the application's behavior at runtime.
- Reuse and Organization: You can define similar behaviors independently and reuse them in different contexts. This helps keep the code clean and organized.
- Open/Closed Principle: Adding new strategies does not require you to change existing classes. This reduces the risk of changes made to existing code.
- Compliance with SOLID Principles: The strategy model emphasizes that a class should only change for one reason, in accordance with the Single Responsibility Principle, one of the SOLID principles.

<h5 align="left"> Disadvantages of the Strategy design pattern</h5>

- Complexity: The strategy model can provide an overly complex solution for simple problems. For small applications, the extra classes and interfaces introduced by this model may be unnecessary.
- Increasing the Number of Objects: Creating a separate class for each strategy may increase the memory usage of the application and have negative effects on performance.
- Understanding the Connection Between Context and Strategies: Understanding the interaction between strategy and context can be difficult, especially in large and complex systems.
- Difficulty of Implementation: Choosing and implementing the right strategy can be challenging, especially when there are multiple strategies and a complex context.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. According to our scenario, let's say we will create widgets that implement different animation styles. For example, we may offer a variety of page transition animations that can be used when switching between different pages in an application. For example, let's say we want to dynamically use two different animation types named **FadeTransitionStrategy** and **SlideTransitionStrategy**. First, we create our **Strategy Interface** component named **PageTransitionStrategy**.

```dart
/// [PageTransitionStrategy] is the strategy interface
abstract class PageTransitionStrategy {
  Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  );
}
```

Afterwards, it was time to create the **Concrete Strategies** components named **FadeTransitionStrategy** and **SlideTransitionStrategy**. **PageTransitionStrategy** component is being implemented into these components. After making special adjustments for each animation, our **Concrete Stratagies** components are ready.

```dart
/// [FadeTransitionStrategy] is a concrete strategy
final class FadeTransitionStrategy implements PageTransitionStrategy {
  @override
  Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

/// [SlideTransitionStrategy] is a concrete strategy
final class SlideTransitionStrategy implements PageTransitionStrategy {
  @override
  Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var begin = const Offset(1.0, 0.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end);
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }
}
```

Then it was time to write the **Context** component named **CustomPageRoute**. As mentioned before, this component creates a page redirect class that will contain and use the migration strategy.

```dart
/// [CustomPageRoute] is the context
final class CustomPageRoute extends PageRouteBuilder {
  final Widget page;
  final PageTransitionStrategy transitionStrategy;

  CustomPageRoute({
    required this.page,
    required this.transitionStrategy,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              transitionStrategy.buildTransition(
                  context, animation, secondaryAnimation, child),
        );
}
```

So, let's see how we can use this on the UI side. Let's assume we have two screens named _HomeView_ and _DetailView_. There will be _navigate_ transactions between each other. Let's perform these transitions using different animations in accordance with the **Strategy Design Pattern** we use.

```dart
/// [HomeView] is the main view for the strategy pattern
final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Detail View'),
          onPressed: () {
            Navigator.push(
              context,
              CustomPageRoute(
                page: const DetailView(),
                transitionStrategy: FadeTransitionStrategy(),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// [DetailView] is the detail view for the strategy pattern
final class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail View'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go Back to Home View'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}


/// [StrategyView] is the main view for the strategy pattern
final class StrategyView extends StatelessWidget {
  const StrategyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/605f8e14-a62e-4951-8180-66ecbd18e662" width="250"> <img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/02bf12c8-adcf-4f30-a419-858bcf39a3a3" width="250">

[Return to the beginning of the documentation](#head)

 <h2 align="left"><a id="template-method">Template Method (Behaverioal Patterns)</h2>
  In Flutter, the Template Method pattern can be used to define a common algorithm or workflow in a base widget, allowing subclasses to implement or modify specific parts of that algorithm.

<h4 align="left">The Template Method design pattern has three main components</h4>

- **Abstract Class:** This class defines abstract methods that must be implemented by the template method and subclasses. The template method calls abstract methods and determines the order of steps.
- **Concrete Class:** These classes extend the abstract class and provide specific implementations of abstract methods.
- **Template Method:** The template method is called and executes the algorithm using implementations provided by concrete classes.

<h5 align="left">Advantages of the Template Method design pattern</h5>

- Reusability: Encourages having common code in one place (abstract class).
- Flexibility: Subclasses can change parts of the algorithm without changing its structure.

<h5 align="left"> Disadvantages of the Template Method design pattern</h5>

- Complexity: Can introduce additional layers of abstraction, which can complicate the code.
- Limited Flexibility: Only predefined steps can be modified by subclasses.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. For our scenario, let's say you create a custom button for your Flutter application with a structure (e.g. filler, shape) but different content and behavior. Let's talk about this.

First of all, we write our **Abstract Class** component named **CustomButton**. This component will be implemented by **Concrate Class**s.

```dart
/// [CustomButton] is the abstract class for the template method pattern
abstract class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          // Common styling
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: buildButtonContent(),
      ),
    );
  }

  Widget buildButtonContent(); // Abstract method to be implemented by subclasses

  void onPressed() {
    log("Button Pressed");
  }
}
```

Then he came to write the **Concrete Class** components that implement the **Abstract Class** component named **CustomButton**. We design two different buttons for _Icon_ and _Text_.

```dart
/// [IconCustomButton] is a concrete class
final class IconCustomButton extends CustomButton {
  final IconData icon;

  const IconCustomButton({super.key, required this.icon});

  @override
  Widget buildButtonContent() {
    return Icon(icon);
  }
}

/// [TextCustomButton] is a concrete class
final class TextCustomButton extends CustomButton {
  final String text;

  const TextCustomButton({super.key, required this.text});

  @override
  Widget buildButtonContent() {
    return Text(text);
  }
}
```

Then we start using these buttons on the UI side. In this way, we designed our buttons using the **Templete Design Pattern**.

```dart
/// [TempleteMethodView] is the main view for the template method pattern
final class TempleteMethodView extends StatelessWidget {
  const TempleteMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Template Method Example')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextCustomButton(text: 'Text Button'),
            IconCustomButton(icon: Icons.add),
            // ... other buttons
          ],
        ),
      ),
    );
  }
}
```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/08e1ff70-310e-4c5a-bee7-48471f775967" width="250">

[Return to the beginning of the documentation](#head)

 <h2 align="left"><a id="visitor">Visitor (Behaverioal Patterns)</h2>
  This model contains two types of objects: visitors and elements. Elements are a piece of structure (like widgets in a widget tree in Flutter), and visitors are objects that perform operations on these elements. The main idea is to add new operations to existing object structures without changing the structures.

<h4 align="left">The Visitor design pattern has four main components</h4>

- **Visitor Interface:** Defines a visit operation for each type of element in the object structure. In Flutter, these can be different types of widgets.
- **Concrete Visitor:** Implements the visitor interface and defines the operation to be performed on the elements.
- **Element Interface:** Provides an accept method that takes a visitor as an argument.
- **Concrete Element:** These are real objects that implement the element interface. In Flutter, widgets play this role.

<h5 align="left">Advantages of the Visitor design pattern</h5>

- Extensibility: You can add new operations without changing widget classes.
- Separation of Responsibilities: Operations on widgets are separated from the logic of the widget itself.
- Single Responsibility Principle: Each class has clear responsibilities – widgets for UI, visitors for specific operations.

<h5 align="left"> Disadvantages of the Visitor design pattern</h5>

- Complexity: The model may overcomplicate the design for simple scenarios.
- Tangible Connection: Leads to a high degree of connection as visitors need to know the details of the elements.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. In our scenario, let's say we will consider a class of visitors who update certain properties or manipulate them in different ways as they navigate different types of widgets. For example, we may want to dynamically change the padding or margin values of a series of texts.

First of all, we write our **Visitor Interface** component named **WidgetVisitor**. This component contains a method with the method signature _visitText(VisitableText text)_. This method decides what work to do on the visited elements. In our case, we parametrically import a **Concrete Element** component named **VisitableText**.

```dart
/// [WidgetVisitor] is the interface for the visitor pattern. Visitor Interface
abstract class WidgetVisitor {
  Widget visitText(VisitableText text);
}
```

Afterwards, we write our **Element Interface** component named **VisitableWidget**. This component has the _accept(WidgetVisitor visitor)_ method signature and takes a parameter of type **Visitor Interface**.
In the _accept_ method, the visitor (_WidgetVisitor_) is enabled to call the _accept_ method. This approach allows the visitor to apply the custom action defined on **VisitableText**.

```dart
/// [VisitableWidget] is the interface for the elements in the object structure. Element Interface
abstract class VisitableWidget {
  Widget accept(WidgetVisitor visitor);
}

```

Then it was time to write our **Concrete Visitor** component named **PaddingAdjuster**. This component contains the steps to be applied to the elements. In our case, since this is a padding adjustment, we have padding-focused content. We _@override_ the _visitText_ method to apply padding to the relevant component.

```dart
/// [PaddingAdjuster] is a concrete visitor that implements the [WidgetVisitor] interface.
final class PaddingAdjuster implements WidgetVisitor {
  final double padding;

  PaddingAdjuster({required this.padding});

  @override
  Widget visitText(VisitableText text) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: text,
    );
  }
}
```

We are writing our **Concrete Element** component named **VisitableText**. This component implements the **Element Interface** component and corresponds to real widgets in Flutter. In our case this is a **Text** component.

```dart
/// [VisitableText] is a concrete element that implements the [CustomWidget] interface.
final class VisitableText extends StatelessWidget implements VisitableWidget {
  final String text;

  const VisitableText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }

  @override
  Widget accept(WidgetVisitor visitor) {
    return visitor.visitText(this);
  }
}
```

So, let's see how we can use this on the UI side. As per our scenario, let's increase and decrease the padding value of the relevant **Text** widget.

```dart
/// [VisitorView] is a view that visitor design pattern is implemented.
final class VisitorView extends StatefulWidget {
  const VisitorView({super.key});

  @override
  State<VisitorView> createState() => _VisitorViewState();
}

class _VisitorViewState extends State<VisitorView> {
  late double _currentPadding;

  @override
  void initState() {
    _currentPadding = 0;
    super.initState();
  }

  void increasePadding() {
    setState(() {
      _currentPadding += 10;
    });
  }

  void decreasePadding() {
    setState(() {
      if (_currentPadding > 0) {
        _currentPadding = _currentPadding - 10;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final paddingAdjuster = PaddingAdjuster(padding: _currentPadding);

    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Pattern')),
      body: const VisitableText(text: 'Hello Visitor').accept(paddingAdjuster),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: increasePadding,
            mini: true,
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: decreasePadding,
            mini: true,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/175de900-bd3b-45f2-af8f-12b080a00bc7" width="250">

[Return to the beginning of the documentation](#head)

<h2 align="left"><a id="momento">Momento (Behaverioal Patterns)</h2>
  The Memento Design Pattern is a behavioral design pattern used to capture and externalize the internal state of an object so that the object can return to that state later. In the Flutter framework, it is especially useful when dealing with the states of widgets.

<h4 align="left">The Momento design pattern has three main components</h4>

- **Originator:** The parent object whose state you want to save and restore. In Flutter, this could be a widget or model class. Creates a memento containing a snapshot of your current internal state.
- **Memento:** A value object that acts as a snapshot of the resource's state. It must be immutable and only accessible by the source.
- **Caretaker:** It is the object responsible for the security of the memento, but it does not process or examine the content of the memento. In Flutter, this can be a manager or controller class.

<h5 align="left">Advantages of the Momento design pattern</h5>

- Extensibility: You can add new operations without changing widget classes.
- Separation of Responsibilities: Operations on widgets are separated from the logic of the widget itself.
- Single Responsibility Principle: Each class has clear responsibilities – widgets for UI, visitors for specific operations.

<h5 align="left"> Disadvantages of the Momento design pattern</h5>

- Complexity: The model may overcomplicate the design for simple scenarios.
- Tangible Connection: Leads to a high degree of connection as visitors need to know the details of the elements.

**Sample Scenario**

How about doing this in an actual application, package, etc. How can we implement it? Let's look at it. For our scenario, let's say we consider a shopping application. Users can add or remove items from the cart, and we want to make these changes reversible.

First, we design the model whose status we want to monitor. In our scenario this will be a _Product_ model.

```dart
/// [Product] class is a model class that holds the product details.
@immutable
final class Product {
  final String name;
  final double price;

  const Product({
    required this.name,
    required this.price,
  });
}

```

Then let's start by writing our **Memento** component named **CartMemento**. This component contains the _copy()_ method to instantly make a copy of the products in the cart. We will use this method in the _saveState()_ method in the **CartCaretaker** component to track the state of the cart each time. In this way, we will be able to add/remove products removed/added from the cart without going to the relevant product page.

```dart
/// [CartMemento] class is a memento class that holds the state of the [Cart].
final class CartMemento {
  final List<Product> products;

  CartMemento(this.products);

  /// [copy] method is used to create a copy of the [CartMemento] object.
  CartMemento copy() => CartMemento(
        List.from(
          products,
        ),
      );
}
```

Next, we create our **Caretaker** component named **CartCaretaker**. This component includes _saveState(CartMemento memento)_, _undo()_ methods. While the _saveState_ method instantly updates the state and creates a copy, the _undo_ method allows the transactions in the basket to be undone.

```dart
/// [CartCaretaker] class is responsible for keeping the history of the [CartMemento] objects.
final class CartCaretaker {
  List<CartMemento> _history = [];
  int _currentIndex = -1;

  void saveState(CartMemento memento) {
    CartMemento mementoCopy = memento.copy();

    if (_currentIndex != _history.length - 1) {
      _history = _history.sublist(0, _currentIndex + 1);
    }
    _history.add(mementoCopy);
    _currentIndex = _history.length - 1;
  }

  CartMemento? undo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      return _history[_currentIndex];
    }
    return null;
  }
}
```

Finally, we move the **Product** model onto _Widget_ and write the **Originator** component named **ShoppingCartWidget**. The _Widget_ we will follow is now **ShoppingCartWidget** according to our scenario.

```dart
/// [ShoppingCartWidget] Originator
final class ShoppingCartWidget extends StatefulWidget {
  const ShoppingCartWidget({super.key});

  @override
  State<ShoppingCartWidget> createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
  List<Product> products = [];
  CartCaretaker caretaker = CartCaretaker();

  @override
  void initState() {
    super.initState();
    saveState();
  }

  void addProduct(Product product) {
    setState(() {
      products.add(product);
      saveState();
    });
  }

  void removeProduct(Product product) {
    setState(() {
      products.remove(product);
      saveState();
    });
  }

  void saveState() {
    caretaker.saveState(CartMemento(products));
  }

  void undo() {
    var memento = caretaker.undo();
    if (memento != null) {
      setState(() {
        products = memento.products;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Products List
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].name),
                    subtitle: Text(products[index].price.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => removeProduct(products[index]),
                    ),
                  );
                },
              ),
            ),

            /// Undo and redo buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Add Product button
                ElevatedButton(
                  onPressed: () => addProduct(Product(
                      name: 'New Product',
                      price: double.parse(
                          (Random().nextDouble() * 100).toStringAsFixed(2)))),
                  child: const Text('Add Product'),
                ),
                const SizedBox(width: 8),

                /// Undo button
                ElevatedButton(
                  onPressed: undo,
                  child: const Text('Undo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


```

<img src="https://github.com/Deatsilence/flutter-design-patterns/assets/78795973/90ba1231-9343-4498-b0fb-6096bd06fb8b" width="250">

[Return to the beginning of the documentation](#head)
