<h1 align="center">Design Patterns with Flutter</h1>

- <h2 align="left">Factory</h2>
  Factory design pattern(Fabrika tasarım deseni) bir nesnenin nasıl oluşturulacağını soyutlaştırmaya yardımcı olan bir yaratımsal tasarım modelidir. Bu, kodunuzun daha esnek ve genişletilebilir olmasını sağlar.

Fabrika tasarım deseninin temel fikri, nesne oluşturma işlemini bir fabrika sınıfına devretmektir. Bu fabrika sınıfı, hangi nesnenin oluşturulacağını belirler.

<h4 align="left">Fabrika tasarım deseninin iki ana bileşeni vardır:</h4>

- **Ürün:** Oluşturulacak nesnedir.
- **Fabrika:** Ürün nesnesini oluşturan sınıftır.

<h5 align="left">Fabrika tasarım deseninin avantajları:</h5>

- Kodunuzu daha esnek ve genişletilebilir hale getirir.
- Nesne oluşturma işlemini soyutlaştırarak kodunuzun daha okunaklı ve anlaşılır olmasını sağlar.
- Yazılım geliştirme sürecini daha verimli hale getirir.

<h5 align="left"> Fabrika tasarım deseninin dezavantajları:</h5>

- Karmaşık uygulamalarda kullanımı zor olabilir.
- Daha fazla kod yazmanıza neden olabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. Senaryomuz gereği platforma özgü buton üretmek istiyoruz. Bunun için ilk önce **abstract** bir sınıf oluşturmaya başlıyoruz. İçinde **Widget** döndüren build ismine sahip bir **abstract** method yazıyoruz. Bu method için en temel parametre olarak **onPressed** ve **child** istiyorum. Bu senaryonuza göre değişebilir. Mevcut platformu öğrenmek için `import 'dart:io' show Platform;` ile Platform sınıfını kullanıyorum. Altarnatif olarak `Theme.of(context).platform.` kullanılabilir. Mevcut platforma göre ilgili platforma özel butonu döndüren bir abstract bir factory sınıfımız var.

```
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

IOS ve Android olmak üzere 2 platforma özel buton sınıflarımızı oluşturup **PlatformButton** sınıfımızı implemente ederek Widget içinde ilgili butonlarımızı döndürdük.

```
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

Peki bunu UI tarafında nasıl kullanabiliriz ?

```
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

- <h2 align="left">Abstract Factory</h2>

Soyut fabrika tasarım deseni, birden çok aileden nesne oluşturmak için bir fabrika sınıfı kullanır. Bu desen, nesne oluşturma işlemini soyutlaştırarak kodunuzun daha okunaklı ve esnek olmasını sağlar.

<h4 align="left">Soyut fabrika tasarım deseninin iki ana bileşeni vardır:</h4>

- **Soyut fabrika:** Birden çok aileden nesne oluşturmak için kullanılan bir sınıftır.
- **Somut fabrika:** Soyut fabrikayı somutlaştıran ve belirli bir aileden nesneler oluşturmak için kullanılan bir sınıftır.

<h5 align="left">Soyut fabrika tasarım deseninin avantajları:</h5>

- Kodunuzu daha esnek ve genişletilebilir hale getirir.
- Nesne oluşturma işlemini soyutlaştırarak kodunuzun daha okunaklı ve anlaşılır olmasını sağlar.
- Yazılım geliştirme sürecini daha verimli hale getirir.

<h5 align="left"> Soyut fabrika tasarım deseninin dezavantajları:</h5>

- Karmaşık uygulamalarda kullanımı zor olabilir.
- Daha fazla kod yazmanıza neden olabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Ona bakalım. İlk bakışta **Factory Method** ile karıştırılması doğal olsa da aralarında ufak bir farklılık var. Bu fark **Factory Method** aynı aile içerisinde bulunması gereken nesneleri soyutlaştırarak üretirken. Örneğin _IOS Button, Android Button, Linux Button, vb._ gibi buton ailesisini kapsayabilir. **Abstract Factory** ise farklı ailelerin nesnelerini soyutlaştırarak üretir. Örneğin _Button, Indicator, vb._ gibi farklı ailele sınıflarını kendi bünyesinde üretebilir. **Factory Method** için yaptığımız platforma özgü butona ek olarak platforma özgü indicator ekledikten sonra bu iki farklı aileye ait componentleri **Abstract Factory** ile üretelim. Bunun için 2 farklı teknik göstereceğim. 1. Teknikte **Singleton + Abstract Factory** design patterns beraber kullanılmaktadır. 2. Teknikte bir class içinde static methodlar kullanılmaktadır.

** 1. Teknik (Singleton + Abstract Factory):
Öncelikle **abstract** bir sınıf olarak **AbstractFactory** sınıfımızı oluşturuyoruz. İçinde **buildButton() ve buildIndicator()** ismine sahip 2 tane **abstract method\*\* oluşturuyoruz.

```
abstract class AbstractFactory {
  Widget buildButton({required VoidCallback onPressed, required Widget child});
  Widget buildIndicator();
}
```

Sonrasında **AbstractFactoryImpl2** adında **Singleton** sınıf oluşturup **AbstractFactory** sınıfını implemente ediyoruz.
**AbstractFactoryImpl2** içerisinde ailelere özel Widget döndüren methodlarımızı override ediyoruz.

```
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

Peki bunu UI tarafında nasıl kullanabiliriz ?

```
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

\*\* 2. Teknik (Abstract Factory):

```
final class AbstractFactoryImpl {
  static Widget buildButton({required VoidCallback onPressed, required Widget child}) {
    return PlatformButton().build(onPressed: onPressed, child: child);
  }

  static Widget buildIndicator() {
    return PlatformIndicator().build();
  }
}

```

Peki bunu UI tarafında nasıl kullanabiliriz ?

```
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

Hangi yöntemin kullanılacağı projenin gereksinimlerine ve diğer parametrelere bağlıdır.

- <h2 align="left">Singleton</h2>
  Singleton tasarım deseni, bir sınıftan yalnızca bir nesnenin oluşturulmasını sağlar. Bu desen, tek bir nesnenin ihtiyaç duyulduğu durumlarda kullanılır.

<h4 align="left">Singleton tasarım deseninin iki ana bileşeni vardır:</h4>

- **Singleton sınıfı:** Yalnızca bir nesnenin oluşturulmasını sağlayan sınıftır..
- **Singleton nesnesi:** Singleton sınıfından oluşturulan tek nesnedir.

<h5 align="left">Singleton tasarım deseninin avantajları:</h5>

-Tek bir nesnenin ihtiyaç duyulduğu durumlarda kullanışlıdır.
-Kodunuzu daha okunaklı ve anlaşılır hale getirir.
-Yazılım geliştirme sürecini daha verimli hale getirir.

<h5 align="left"> Fabrika tasarım deseninin dezavantajları:</h5>

- Karmaşık uygulamalarda kullanımı zor olabilir.
- Daha fazla kod yazmanıza neden olabilir.

**Örnek Senaryo**

Peki bunu gerçek bir uygulamada, pakette, vb. nasıl uygulayabiliriz ? Genelde uygulamanın network katmanı için kullanmak faydalı bir davranıştır. Aşağıda girilen konumlara göre benzer konumları getiren bir network servis katmanı vardır.

```
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

Peki bunu UI tarafında nasıl kullanabiliriz ?

```
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
