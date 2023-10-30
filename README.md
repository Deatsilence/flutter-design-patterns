<h1 align="center">Design Patterns with Flutter</h1>

- <h2 align="left">Factory Method</h2>
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
